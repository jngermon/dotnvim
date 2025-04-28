return function()
    local conformUtil = require("conform.util")
    local util = require("core.util")
    local neoconf = require("neoconf")
    local conf = neoconf.get("php", {
        root = "",
        phpcsfixer = {
            ignore_env = true,
            config = "",
        },
        docker = {
            root = false,
            container = false,
        },
    })

    local function findCmd(config, ctx)
        return conformUtil.find_executable({
            "tools/php-cs-fixer/vendor/bin/php-cs-fixer",
            "vendor/bin/php-cs-fixer",
        }, "php-cs-fixer")(config, ctx)
    end

    local function pathReplaceForDocker(path)
        if not conf.docker.root then
            return path
        end
        path = string.gsub(path, "^" .. string.gsub(vim.uv.cwd() or "", "([^%w])", "%%%1"), "")
        path = string.gsub(path, "^%/" .. string.gsub(conf.root or "", "([^%w])", "%%%1"), conf.docker.root or "")

        return path
    end

    ---@type conform.FormatterConfigOverride
    return {
        meta = {
            url = "https://github.com/PHP-CS-Fixer/PHP-CS-Fixer",
            description = "The PHP Coding Standards Fixer.",
        },
        command = function(config, ctx)
            if conf.docker and conf.docker.container then
                return "docker"
            end

            local cmd = findCmd(config, ctx)
            if conf.phpcsfixer.ignore_env then
                cmd = "PHP_CS_FIXER_IGNORE_ENV=1 " .. cmd
            end

            return cmd
        end,
        args = function(config, ctx)
            if conf.docker and conf.docker.container then
                return util.cleanTable({
                    "exec",
                    conf.docker.root and ("--workdir=" .. conf.docker.root) or nil,
                    conf.phpcsfixer.ignore_env and "--env" or nil,
                    conf.phpcsfixer.ignore_env and "PHP_CS_FIXER_IGNORE_ENV=1" or nil,
                    conf.docker.container,
                    pathReplaceForDocker(findCmd(config, ctx)),
                    "fix",
                    conf.phpcsfixer.config ~= "" and ("--config=" .. conf.phpcsfixer.config) or nil,
                    pathReplaceForDocker(ctx.filename),
                })
            end
            return { "fix", "$FILENAME" }
        end,
        stdin = false,
        cwd = function(config, ctx)
            local cwd = conformUtil.root_file({ "composer.json" })(config, ctx)
            return cwd
        end,
    }
end
