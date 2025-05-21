local map = vim.keymap.set
local opts = { noremap = true, silent = true }
vim.g.mapleader = ' '
map('n', '<leader>w', '<CMD>w<CR>', opts)
map('n', '<leader>q', '<CMD>q<CR>', opts)
map('n', '<leader>wq', '<CMD>wq<CR>', opts)
map('n', '<leader>wqa', '<CMD>wqa<CR>', opts)
map('n', ';', ':', opts)
-- map('n', '<leader>w', '<CMD><CR>', opts)
-- map('n', '<leader>w', '<CMD><CR>', opts)
