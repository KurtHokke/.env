local map = vim.keymap.set
local unmap = vim.keymap.del
map({'n', 'v'}, '<Up>', '<Nop>', { noremap = true })
map({'n', 'v'}, '<Down>', '<Nop>', { noremap = true })
map({'n', 'v'}, '<Left>', '<Nop>', { noremap = true })
map({'n', 'v'}, '<Right>', '<Nop>', { noremap = true })

map("n", "e", "<Enter>")
map("i", "<A-e>", "<Enter>")
-- Preserve your existing Alt+h/j/k/l insert-mode mappings (May 24, 2025)
map("i", "<A-h>", "<Left>", { noremap = true, silent = true, desc = "Move left in insert mode" })
map("i", "<A-j>", "<Down>", { noremap = true, silent = true, desc = "Move down in insert mode" })
map("i", "<A-k>", "<Up>", { noremap = true, silent = true, desc = "Move up in insert mode" })
map("i", "<A-l>", "<Right>", { noremap = true, silent = true, desc = "Move right in insert mode" })

map("n", "<A-h>", "5h", { noremap = true, silent = true, })
map("n", "<A-j>", "5j", { noremap = true, silent = true, })
map("n", "<A-k>", "5k", { noremap = true, silent = true, })
map("n", "<A-l>", "5l", { noremap = true, silent = true, })

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- map("n", "<leader>W", "<CMD>wqa<CR>")
-- map("n", "<leader>w", "<CMD>w<CR>")
-- map("n", "<leader>Q", "<CMD>qa<CR>")
-- map("n", "<leader>q", "<CMD>q<CR>")
map("n", "q", "<CMD>q<CR>")
map("n", "Q", "<CMD>qa<CR>")
map("n", "<leader>`", "<CMD>Inspect<CR>")

-- map("n", "<A-r>", "<CMD>luafile ~/.config/nvim/lua/custom/hlConfig.lua<CR>")
map({"n", "i"}, "<A-u>", "<CMD>u<CR>")
map("c", "<C-a>", "<home>")
map("c", "<C-e>", "<end>")

map("n", "<Tab>", "<CMD>BufferNext<CR>")

local mytree = require("pconfig.nvimtree").mytree
map("n", "<A-e>", function()
  mytree({ toggle = true })
end)
-- map("n", "<C-=>", function()
--   mytree.f({ resize = { relative = 1 } })
-- end)
-- map("n", "<C-->", function()
--   mytree.f({ resize = { relative = -1 } })
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



-- map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
