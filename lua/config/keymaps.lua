-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<leader>D", "<cmd>lua Snacks.dashboard.open()<cr>", { desc = "Dashboard" })

map("n", "<C-u>", "<cmd>redo<cr>", { desc = "Redo", remap = true })

-- For New Keyboard compatibility
map("n", "<C-t>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-s>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-r>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-n>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<S-LEFT>", "<cmd>BufferLineMovePrev<cr>", { desc = "Go to Left Buffer", remap = true })
map("n", "<S-RIGHT>", "<cmd>BufferLineMoveNext<cr>", { desc = "Go to Right Buffer", remap = true })

-- Move Lines
map("n", "<A-s>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-r>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-s>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-r>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-s>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-r>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
