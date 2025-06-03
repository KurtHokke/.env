local map = vim.keymap.set

local nrs = {
  noremap = true,
  silent = true,
}

map('n', 'K', '<Nop>', nrs)
map('n', 'K', '<CMD>FzfLua lsp_finder<CR>', nrs)
