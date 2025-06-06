local map = vim.keymap.set

local rs = {
  remap = true,
  silent = true,
}
local nrs = {
  noremap = true,
  silent = true,
}

map('n', 'K', '<Nop>', nrs)
map('n', 'K', '<CMD>FzfLua lsp_finder<CR>', nrs)

map('t', '<A-j>', '<Down>', rs)
map('t', '<A-k>', '<Up>', rs)
