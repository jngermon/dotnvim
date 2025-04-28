return {
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true,
        init = function()
            local wk = require("which-key")
            wk.add({
                {
                    "<leader>gw",
                    function()
                        engage.conflict_buster()
                        create_buffer_local_mappings()
                    end,
                    desc = "Launch conflict buster",
                },
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
    },
}
