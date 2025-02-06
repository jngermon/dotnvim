return function()
    local util = require("core.util")
    local vendor = "vendor/bin/"
    local bin = "phpstan"
    local neoconf = require("neoconf")
    local conf = neoconf.get("php", {
        root = "",
        phpstan = "",
        docker = {
            root = false,
            container = false,
            user = false,
        },
    })

    local linter = {
        name = "myphpstan",
        ignore_exitcode = true,
    }

    local function pathReplaceForDocker(path)
        if not conf.docker.root then
            return path
        end
        path = string.gsub(path, "^" .. string.gsub(vim.uv.cwd() or "", "([^%w])", "%%%1"), "")
        path = string.gsub(path, "^%/" .. string.gsub(conf.root or "", "([^%w])", "%%%1"), conf.docker.root or "")
        return path
    end

    if conf.docker and conf.docker.container then
        linter.cmd = "docker"
        linter.args = util.cleanTable({
            "exec",
            conf.docker.root and ("--workdir=" .. conf.docker.root) or nil,
            conf.docker.user and ("--user=" .. conf.docker.user) or nil,
            conf.docker.container,
            vendor .. bin,
            "analyze",
            conf.phpstan ~= "" and ("--configuration=" .. conf.phpstan) or nil,
            "--error-format=json",
            "--no-progress",
            function()
                local bufnr = vim.api.nvim_get_current_buf()
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                bufname = pathReplaceForDocker(bufname)

                return bufname
            end,
        })
        linter.stdin = false
        linter.append_fname = false
    else
        local local_bin = vim.fn.fnamemodify((conf.root or "") .. vendor .. bin, ":p")
        linter.cmd = vim.uv.fs_stat(local_bin) and local_bin or bin
        linter.args = util.cleanTable({
            "analyze",
            (conf.root or conf.phpstan)
                    and ("--configuration=" .. conf.root .. (conf.phpstan ~= "" or "phpstan.dist.neon"))
                or nil,
            "--error-format=json",
            "--no-progress",
        })
        linter.stdin = false
        linter.append_fname = true
    end

    linter.parser = function(output, bufnr)
        if vim.trim(output) == "" or output == nil then
            return {}
        end

        local filename = vim.api.nvim_buf_get_name(bufnr)
        filename = pathReplaceForDocker(filename)
        local file = vim.json.decode(output).files[filename]

        if file == nil then
            return {}
        end

        local diagnostics = {}

        for _, message in ipairs(file.messages or {}) do
            table.insert(diagnostics, {
                lnum = type(message.line) == "number" and (message.line - 1) or 0,
                col = 0,
                message = message.message,
                source = bin,
            })
        end

        return diagnostics
    end
    return linter
end
