local opt = vim.opt
local o = vim.o
local g = vim.g

g.starting_directory = vim.fn.getcwd()

o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number" -- to enable cursorline!
o.relativenumber = true

o.number = true
o.numberwidth = 2
o.ruler = false

o.mouse = "a"

o.wrap = false
o.ignorecase = false
o.smartcase = false

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true
-- o.winborder = 'rounded'
-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

opt.termguicolors = true

-- disable nvim intro
opt.shortmess:append "sI"

opt.whichwrap:append "<>[]hl"

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

o.mousemoveevent = true

opt.cmdheight = 0

local pyvenv = vim.fn.stdpath('data') .. '/pyneo/bin'
vim.env.PATH = vim.env.PATH .. ':' .. pyvenv

local libso = vim.fn.stdpath('data') .. '/libso'
package.cpath = package.cpath .. ";" .. libso .. "/?.so"
-- opt.rtp:append(libso)

-- vim.api.nvim_create_autocmd('CmdlineEnter', {
--   callback = function()
--     vim.opt.cmdheight = 1
--   end
-- })
-- vim.api.nvim_create_autocmd('CmdlineLeave', {
--   callback = function()
--     -- vim.defer_fn(function()
--     vim.opt.cmdheight = 0
--     -- end, 1000)
--   end
-- })

require("options.mappings")
