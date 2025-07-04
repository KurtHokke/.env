local map = vim.keymap.set
-- local unmap = vim.keymap.del
local log = require'functions.logger'.log
local stringmani = require'functions.string'
local nrs = {
  noremap = true,
  silent = true,
}
local rs = {
  remap = true,
  silent = true,
}

map('n', 'u', '<Nop>', nrs)
map({'n', 'v'}, ' ', '<Nop>', nrs)
map({'n', 'v'}, '<Up>', '<Nop>', nrs)
map({'n', 'v'}, '<Down>', '<Nop>', nrs)
map({'n', 'v'}, '<Left>', '<Nop>', nrs)
map({'n', 'v'}, '<Right>', '<Nop>', nrs)

-- map({'n', 'v', 'i', 'c'}, '<A-3>', function()
--   log(vim.api.nvim_get_mode().mode, {raw = true})
-- end)

map({'n', 'v', 'i'}, '<A-3>', function ()
  package.loaded["functions._playground"] = nil
  local test = require'functions._playground'.test
  test()
end)

map('n', '<A-2>', function()
  -- package.loaded["functions.fzf"] = nil
  local test = require'functions.fzf'.live_grep_nvimtreedir
  test()
end)
map('n', '<A-1>', function()
  require'functions.inspect'.inspect()
end)
-- map("n", "<A-r>", "<CMD>luafile ~/.config/nvim/lua/options/highlight.lua<CR>")
map("n", "<A-r>", function()
  package.loaded["options.highlight"] = nil
  require'functions.hl_setter'.syntax_hl(require'options.highlight'.hl_table)
end)

map({'n', 'i'}, '<C-CR>', function ()
  local jump = require'functions.jump_to_closing'.jump
  jump()
end)


map('n', '<CR>', 'o')
map('n', '<S-CR>', 'O')

map('n', '<ESC>', '<ESC><CMD>nohlsearch<CR>')

map("n", "e", "<Enter>")
map("i", "<A-e>", "<Enter>")
-- Preserve your existing Alt+h/j/k/l insert-mode mappings (May 24, 2025)
map("i", "<A-h>", "<Left>", nrs)
map("i", "<A-j>", "<Down>", nrs)
map("i", "<A-k>", "<Up>", nrs)
map("i", "<A-l>", "<Right>", nrs)

map({"n", "v"}, "<A-h>", "2h", rs)
map({"n", "v"}, "<A-j>", "3j", rs)
map({"n", "v"}, "<A-k>", "3k", rs)
map({"n", "v"}, "<A-l>", "2l", rs)

map({"n", "v"}, ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- map("n", "<leader>W", "<CMD>wqa<CR>")
-- map("n", "<leader>w", "<CMD>w<CR>")
-- map("n", "<leader>Q", "<CMD>qa<CR>")
-- map("n", "<leader>q", "<CMD>q<CR>")

map("n", "q", function()
  local buf = vim.api.nvim_get_current_buf()
  if not vim.api.nvim_get_option_value("modified", { buf = buf }) then
    vim.api.nvim_command("BufferLineCyclePrev")
    local command = string.format("bdelete! %d", buf)
    vim.api.nvim_command(command)
  else
    local filepath = vim.api.nvim_buf_get_name(buf)
    local title = stringmani.shorten_path(filepath)
    log("Save changes before trying to close buffer", { render = 'compact', level = vim.log.levels.WARN, title = title })
  end
end)

map("n", "<leader>q", "<CMD>qa<CR>")
map("n", "Q", "<CMD>q!<CR>")
map("n", "<leader>`", "<CMD>Inspect<CR>")

map({"n", "i"}, "<A-u>", "<CMD>u<CR>")
map("c", "<C-a>", "<home>")
map("c", "<C-e>", "<end>")

map("n", "<TAB>", "<CMD>BufferLineCycleNext<CR>")

-- local mytree = require'plugins.config.nvimtree'.mytree
-- map("n", "<A-e>", function()
--   mytree({ toggle = true })
-- end)
-- map("n", "<C-=>", function()
--   mytree({ resize = { relative = 1 } })
-- end)
-- map("n", "<C-->", function()
--   mytree({ resize = { relative = -1 } })
-- end)
--
-- local quotejump = require("funcs.quotejump")
-- map({"n", "i"}, "<A-.>", quotejump.jump_to_closing_quote)
-- map({"n", "i"}, "<A-,>", "<Left>")
--
-- local linejump = require("funcs.linejump")
-- map("n", "<A-Down>", function ()
--   linejump.linejump(5)
-- end)
--
-- map({"n", "i"}, "<A-g>", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>")
-- map("n", "<A-w>", "<CMD>WhichKey<CR>")

-- local builtin = require('telescope.builtin')
-- map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
