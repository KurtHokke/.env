local opt = vim.opt
local o = vim.o
local g = vim.g

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

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

o.mousemoveevent = true

-- local is_windows = vim.fn.has "win32" ~= 0
-- local sep = is_windows and "\\" or "/"
-- local delim = is_windows and ";" or ":"
-- vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

require("options.mappings")
