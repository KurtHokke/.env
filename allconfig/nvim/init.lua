-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true
require('config.lazy')
require('options')
require('keymaps')
-- vim.cmd('colorscheme tokyonight')

