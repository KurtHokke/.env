require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>y", "<cmd>NvimTreeFocus<CR>")
map("n", "<leader>`", "<cmd>Inspect<CR>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
