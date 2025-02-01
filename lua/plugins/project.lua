return {
    {
        "coffebar/neovim-project",
        opts = {
            projects = { -- define project roots
                "~/srv/*/*",
                "~/.config/*",
            },
            picker = {
                type = "fzf-lua", --"telescope", -- or "fzf-lua"
                opts = {
                    winopts = {},
                    defaults = {
                        path_shorten = 1,
                    },
                    fzf_opts = {
                        ["--with-nth"] = "2",
                    },
                },
            },
            dashboard_mode = true,
        },
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.

            vim.api.nvim_create_autocmd("User", {
                pattern = "SessionLoadPost",
                callback = function()
                    local session = require("session_manager.utils")
                    local session_name = session.active_session_filename:gsub("^.*__", "")

                    vim.defer_fn(function()
                        require("neo-tree.command").execute({ dir = LazyVim.root(), action = "show" })
                        vim.notify("Current : " .. session_name, vim.log.levels.INFO, { title = "Project" })
                    end, 200)
                end,
            })

            local wk = require("which-key")
            wk.add({
                { "<leader>p", group = "project", icon = { icon = " ", color = "cyan" } }, -- group
                { "<leader>ph", "<cmd>NeovimProjectHistory<cr>", desc = "Open Project history", icon = " " },
                { "<leader>pd", "<cmd>NeovimProjectDiscover<cr>", desc = "Discover new Project", icon = " " },
                { "<leader>ps", "<cmd>NeovimProjectLoadRecent<cr>", desc = "Load recent Project", icon = " " },
            })
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            -- optional picker
            --{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
            -- optional picker
            { "ibhagwan/fzf-lua" },
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
    },
}
