return {
    {
        "saghen/blink.cmp",
        opts = function(_, opts)
            opts.keymap = {
                preset = "enter",
                ["<C-CR>"] = { "cancel" },
            }
        end,
        -- version = "v0.10.0",
    },
    require("luasnip.loaders.from_snipmate").lazy_load(),
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/my_snippets" }),
}
