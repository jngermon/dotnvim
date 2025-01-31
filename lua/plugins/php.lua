return {
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
        },
        init = function()
            require("lint").linters.myphpstan = require("core.lint.linters.myphpstan").generate()
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                php = { "php_cs_fixer" },
            },
        },
    },
}
