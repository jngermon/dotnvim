-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
    callback = function()
        vim.defer_fn(function()
            vim.notify("LspRestart...")
            vim.cmd("LspRestart")
        end, 200)
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "GitConflictDetected",
    callback = function()
        vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
        vim.keymap.set("n", "cww", function()
            engage.conflict_buster()
            create_buffer_local_mappings()
        end)
    end,
})
