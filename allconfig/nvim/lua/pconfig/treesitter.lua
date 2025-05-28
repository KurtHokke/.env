local M = {}
M.opts = {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
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
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  -- sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
  },
}

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
