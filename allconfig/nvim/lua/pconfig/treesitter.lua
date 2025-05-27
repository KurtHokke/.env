local M = {}
function M.install()
  require('nvim-treesitter').install({
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
    "bash",
    "c",
    "cpp",
    "css",
    "cmake",
    "desktop"
  })
end
-- function M.filetypes()
--   vim.api.nvim_create_autocmd( 'FileType', { pattern = 'lua',
--     callback = function(args)
--       vim.treesitter.start(args.buf, 'lua')
--       vim.treesitter.start(args.buf, 'luadoc')
--       -- vim.bo[args.buf].syntax = 'on'  -- only if additional legacy syntax is needed
--     end
--   })
--   vim.api.nvim_create_autocmd( 'FileType', { pattern = 'vim',
--     callback = function(args)
--       vim.treesitter.start(args.buf, 'vim')
--       vim.treesitter.start(args.buf, 'vimdoc')
--     end
--   })
--   vim.api.nvim_create_autocmd( 'FileType', { pattern = 'c',
--     callback = function(args)
--       vim.treesitter.start(args.buf, 'c')
--     end
--   })
--   vim.api.nvim_create_autocmd( 'FileType', { pattern = 'sh',
--     callback = function(args)
--       vim.treesitter.start(args.buf, 'bash')
--     end
--   })
-- end
return M
