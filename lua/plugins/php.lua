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
            linters_by_ft = {
                php = { "phpstan" },
            },
        },
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
