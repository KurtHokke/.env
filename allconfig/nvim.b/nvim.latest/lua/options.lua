require "nvchad.options"

-- add yours here!
-- vim.diagnostic.config({ virtual_text = false })

local o = vim.o

o.cursorlineopt = "both" -- to enable cursorline!
o.wrap = false
o.smartindent = true
o.relativenumber = true
o.ignorecase = false
o.smartcase = false
-- vim.g.clipboard = 'clip'
-- vim.g.clipboard = {
--   name = "wsl",
--   copy = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe",
--   },
--    ["+"] = ""
--   }
-- }

require "hlConfig"

