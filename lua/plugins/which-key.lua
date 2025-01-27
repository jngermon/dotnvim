local wk = require("which-key")
wk.add({
    { "<leader>p", group = "project", icon = { icon = " ", color = "cyan" } }, -- group
    { "<leader>ph", "<cmd>NeovimProjectHistory<cr>", desc = "Open Project history", icon = " " },
    { "<leader>pd", "<cmd>NeovimProjectDiscover<cr>", desc = "Discover new Project", icon = " " },
    { "<leader>ps", "<cmd>NeovimProjectLoadRecent<cr>", desc = "Load recent Project", icon = " " },
    {
        -- Nested mappings are allowed and can be added in any order
        -- Most attributes can be inherited or overridden on any level
        -- There's no limit to the depth of nesting
        mode = { "n", "v" }, -- NORMAL and VISUAL mode
        { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
        { "<leader>w", "<cmd>w<cr>", desc = "Write" },
    },
})

return {}
