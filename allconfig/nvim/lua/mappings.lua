require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>W", "<CMD>wqa<CR>")
map("n", "<leader>Q", "<CMD>qa<CR>")
map("n", "<leader>q", "<CMD>q<CR>")
map("n", "<leader>E", "<CMD>NvimTreeClose<CR>")
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
