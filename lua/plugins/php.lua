return {
    {
        "neovim/nvim-lspconfig",
        init = function()
            require("lspconfig").intelephense.setup({
                root_dir = function(path, buf)
                    local root = require("lspconfig.util").root_pattern("composer.json", ".git")(path)
                    if root == nil then
                        return path:match("(.*[/\\])")
                    end
                    return root
                end,
            })
        end,
        dependencies = {
            { "folke/neoconf.nvim" },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                --"phpcs",
                "php-cs-fixer",
                "phpstan",
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            events = { "BufWritePost", "BufReadPost" },
            linters_by_ft = {
                php = { "myphpstan" },
            },
            linters = {
                myphpstan = require("core.lint.linters.myphpstan"),
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                php = { "my_php_cs_fixer" },
            },
            formatters = {
                my_php_cs_fixer = require("core.conform.formatters.my-php-cs-fixer"),
            },
        },
    },
}
