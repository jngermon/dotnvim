return {
    {
        "saghen/blink.cmp",
        version = "v0.10.0",
    },
    require("luasnip.loaders.from_snipmate").lazy_load(),
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/my_snippets" }),
}
