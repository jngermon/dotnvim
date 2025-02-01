return {
    {
        "snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    pick = function(cmd, opts)
                        return LazyVim.pick(cmd, opts)()
                    end,
                    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
 ]],
                    -- stylua: ignore
                    ---@type snacks.dashboard.Item[]
                    keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "p", desc = "Recent Projects", action = "<cmd>NeovimProjectHistory<cr>" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "header" },
                    {
                        pane = 2,
                        section = "terminal",
                        cmd = "chafa ~/.dotfiles/files/images/blacksab-1.mirror.png  -c none --symbols braille --size 60x17 --stretch; sleep .1",
                        height = 17,
                        padding = 1,
                    },
                    { section = "keys", gap = 1, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Projects",
                        section = "custom",
                        indent = 2,
                        padding = 1,
                        limit = 10,
                    },
                    { section = "startup" },
                },
            },
        },
        dependencies = {
            { "princejoogie/chafa.nvim" },
        },
        init = function()
            local dashboard = require("snacks.dashboard")

            dashboard.sections.custom = function(opts)
                local history = require("neovim-project.utils.history")
                local project = require("neovim-project.project")
                local limit = opts.limit or 5
                local recents = history.get_recent_projects()

                recents = vim.list_slice(vim.iter(recents):rev():totable(), 1, limit)
                local ret = {} ---@type snacks.dashboard.Item[]
                for _, recent in ipairs(recents) do
                    ret[#ret + 1] = {
                        file = recent,
                        icon = "directory",
                        action = function(self)
                            project.switch_project(recent)
                        end,
                        autokey = true,
                    }
                end
                return ret
            end
        end,
    },
}
