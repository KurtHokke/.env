local Z = {}

function Z.colorscheme()
  require('onedark').setup {
    style = 'darker'
  }
  require('onedark').load()
end

Z.yazi = {
  event = "VeryLazy",
  deps = {
    -- check the installation instructions at
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<A-f>",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    -- {
    --   -- Open in the current working directory
    --   "<A-e>",
    --   mode = { "n", "v" },
    --   "<cmd>Yazi cwd<cr>",
    --   desc = "Open the file manager in nvim's working directory",
    -- },
    {
      "<A-e>",
      mode = { "n", "v" },
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    -- init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      -- vim.g.loaded_netrwPlugin = 1
    -- end,
  },
}

Z.barbar = {
  event = "BufReadPost",
  deps = {
    -- 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {},
}

Z.lualine = {
  deps = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}

Z.treesitter = {
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "bash", "c" },

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = { enable = true },
  },
}


Z.lsp_config = {
  lazy = true,
  deps = {
    {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = { "lua_ls", "clangd", "codelldb", "bashls" },
        },
      },
      opts = {},
    },
  },
  opts = {},
}

-- Z.autopairs = {
--   -- event = "InsertEnter",
--   -- config = true,
--   -- opts = {},
--   opts = {
--     fast_wrap = {},
--     disable_filetype = { "TelescopePrompt", "vim" },
--   },
--   config = function(_, opts)
--     require("nvim-autopairs").setup(opts)
--     -- setup cmp for autopairs
--     local cmp_autopairs = require "nvim-autopairs.completion.cmp"
--     require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
--   end,
-- }
--
-- Z.cmp = {
--   deps = {
--     -- General
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-cmdline",
--     {
--       "windwp/nvim-autopairs",
--       opts = Z.autopairs.opts,
--       config = function(_, opts)
--         Z.autopairs.config(_, opts)
--       end,
--     },
--     -- Lua
--     "L3MON4D3/LuaSnip"
--     "saadparwaiz1/cmp_luasnip"
--   },
--   setup = function()
--     local cmp = require("cmp")
--
--   cmp.setup({
--     snippet = {
--       -- REQUIRED - you must specify a snippet engine
--       expand = function(args)
--         require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
--         vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--
--         -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--         -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--
--         -- For `mini.snippets` users:
--         -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
--         -- insert({ body = args.body }) -- Insert at cursor
--         -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
--         -- require("cmp.config").set_onetime({ sources = {} })
--       end,
--     },
--     window = {
--       completion = cmp.config.window.bordered(),
--       documentation = cmp.config.window.bordered(),
--     },
--     mapping = cmp.mapping.preset.insert({
--       ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--       ['<C-f>'] = cmp.mapping.scroll_docs(4),
--       ['<C-Space>'] = cmp.mapping.complete(),
--       ['<C-e>'] = cmp.mapping.abort(),
--       ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     }),
--     sources = cmp.config.sources({
--       { name = 'nvim_lsp' },
--       { name = 'vsnip' }, -- For vsnip users.
--       -- { name = 'luasnip' }, -- For luasnip users.
--       -- { name = 'ultisnips' }, -- For ultisnips users.
--       -- { name = 'snippy' }, -- For snippy users.
--     }, {
--       { name = 'buffer' },
--     })
--   })
--   end,
--
-- "hrsh7th/nvim-cmp"
-- }

Z.lsp_signature = {
  event = "InsertEnter",
  deps = {
    "neovim/nvim-lspconfig",
  },
  opts = {},
}
-- Z.guihua = {
--   opts = {
--   -- default mapping
--     maps = {
--       close_view = '<C-e>',
--       send_qf = '<C-q>',
--       save = '<C-s>',
--       jump_to_list = '<C-w>k',
--       jump_to_preview = '<C-w>j',
--       prev = '<C-p>',
--       next = '<C-n>',
--       pageup = '<C-b>',
--       pagedown = '<C-f>',
--       confirm = '<C-o>',
--       split = '<C-s>',
--       vsplit = '<C-v>',
--       tabnew = '<C-t>',
--     },
--   },
--
--   -- default icons for panel
--   -- will be tbl_deep_extend() if you override any of those
--   -- local icons = {
--   --   panel_icons = {
--   --     section_separator = '─', --'',
--   --     line_num_left = ':', --'',
--   --     line_num_right = '', --',
--   --
--   --     range_left = '', --'',
--   --     range_right = '',
--   --     inner_node = '', --├○',
--   --     folded = '◉',
--   --     unfolded = '○',
--   --
--   --     outer_node = '', -- '╰○',
--   --     bracket_left = '', -- ⟪',
--   --     bracket_right = '', -- '⟫',
--   --   },
--   --   syntax_icons = {
--   --     var = ' ', -- "👹", -- Vampaire
--   --       method = 'ƒ ', --  "🍔", -- mac
--   --       ['function'] = ' ', -- "🤣", -- Fun
--   --       ['arrow_function'] = ' ', -- "🤣", -- Fun
--   --         parameter = '', -- Pi
--   --           associated = '🤝',
--   --     namespace = '🚀',
--   --     type = ' ',
--   --     field = '🏈',
--   --     interface = '',
--   --     module = '📦',
--   --     flag = '🎏',
--   --   },
--   -- },
-- }
-- Z.navigator = {
--   deps = {
--     {
--       "ray-x/guihua.lua",
--       -- lazy = true,
--       build = "cd lua/fzy && make",
--       opts = Z.guihua.opts,
--     },
--     {
--       "neovim/nvim-lspconfig",
--       dependencies = {
--         {
--           "mason-org/mason.nvim",
--           opts = {
--             ensure_installed = { "lua_ls", "clangd", "codelldb", "bashls" },
--           },
--         },
--         {
--           "mason-org/mason-lspconfig.nvim",
--           opts = {},
--         },
--       },
--     },
--   },
--   opts = {
--     lsp = {
--       disable_lsp = { "vuels", "ts_ls" },
--     },
--   },
-- }
Z.which_key = {
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

return Z
