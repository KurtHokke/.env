require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set
local umap = vim.keymap.del

vim.keymap.set({'n', 'v'}, '<Up>', '<Nop>', { noremap = true })
vim.keymap.set({'n', 'v'}, '<Down>', '<Nop>', { noremap = true })
vim.keymap.set({'n', 'v'}, '<Left>', '<Nop>', { noremap = true })
vim.keymap.set({'n', 'v'}, '<Right>', '<Nop>', { noremap = true })

map("n", "e", "<Enter>")

map("i", "<A-h>", "<Left>")
map("i", "<A-j>", "<Down>")
map("i", "<A-k>", "<Up>")
map("i", "<A-l>", "<Right>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>W", "<CMD>wqa<CR>")
map("n", "<leader>w", "<CMD>w<CR>")
map("n", "<leader>Q", "<CMD>qa<CR>")
map("n", "<leader>q", "<CMD>q<CR>")
map("n", "q", "<CMD>q<CR>")
map("n", "<leader>`", "<CMD>Inspect<CR>")

-- map("n", "<A-r>", "<CMD>luafile ~/.config/nvim/lua/hlConfig.lua<CR>")
-- local quotejump = require("quotejump")
-- map({"n","i"}, "<A-j>", quotejump.jump_to_closing_quote, { desc = "Jump to before closing quote" })
-- map("v", "<C-c>", "!echo <C-r>=escape(substitute(shellescape(getreg('\"')), '\n', '\r', 'g'), '#%!')<CR> <Bar> clip.exe<CR><CR>")
map({"n", "i"}, "<A-u>", "<CMD>u<CR>")

map("c", "<C-a>", "<home>")
map("c", "<C-e>", "<end>")

map("n", "<A-r>", "<CMD>luafile ~/.config/nvim/lua/hlConfig.lua<CR>")

map("n", "<leader>win", "<CMD>set clipboard+=unnamedplus<CR>")

local mytree = require("funcs.myNvimTree")
map("n", "<A-e>", function()
  mytree.f({ toggle = true })
end)
map("n", "<C-=>", function()
  mytree.f({ resize = { relative = 1 } })
end)
map("n", "<C-->", function()
  mytree.f({ resize = { relative = -1 } })
end)

local quotejump = require("funcs.quotejump")
map({"n", "i"}, "<A-.>", quotejump.jump_to_closing_quote)
map({"n", "i"}, "<A-,>", "<Left>")

local linejump = require("funcs.linejump")
map("n", "<A-Down>", function ()
  linejump.linejump(5)
end)

map({"n", "i"}, "<A-g>", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>")


-- nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
-- nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
-- nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
-- nnoremap gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
-- nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
-- nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>


-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
