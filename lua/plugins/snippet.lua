return {
    -- {
    --     "L3MON4D3/LuaSnip",
    --     -- follow latest release.
    --     version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    --     -- install jsregexp (optional!).
    --     build = "make install_jsregexp",
    -- },
    -- {
    --     "rafamadriz/friendly-snippets",
    --     config = function()
    --         vim.defer_fn(function()
    --             print(vim.fn.stdpath("config"))
    --         end, 500)
    --         require("luasnip.loaders.from_vscode").lazy_load()
    --         require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    --     end,
    -- },
    -- require("luasnip.loaders.from_snipmate").lazy_load(),
}
