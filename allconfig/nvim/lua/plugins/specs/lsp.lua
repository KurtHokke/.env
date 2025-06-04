return {
{
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = function()
    return require'plugins.config.lazydev'.opts
  end
},
{
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  opts = {
    modes = { insert = true, command = true, terminal = false },
    -- skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    -- skip autopair when the cursor is inside these treesitter nodes
    skip_ts = { "string" },
    -- skip autopair when next character is closing pair
    -- and there are more closing pairs than opening pairs
    skip_unbalanced = true,
    -- better deal with markdown code blocks
    markdown = true,
  },
  config = function(_, opts)
    require'plugins.config.mini-pairs'.setup(opts)
  end,
},
{
  "neovim/nvim-lspconfig",
  config = function()
    require("init_lsp")
  end,
},
{
  'saghen/blink.cmp',
  -- enabled = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      -- "moyiz/blink-emoji.nvim",
      -- "MahanRahmati/blink-nerdfont.nvim",
    },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      build = "make install_jsregexp",
      -- opts = {},
      -- dependencies = 'rafamadriz/friendly-snippets',
      config = function()
        require'plugins.config.luasnip'
      end,
    },
  },
  version = '1.*',
  opts = function() return require'plugins.config.blink'.opts end,
  opts_extend = function()
    return require'plugins.config.blink'.opts_extend
  end
},
{
  "folke/trouble.nvim",
  opts = function() return require'plugins.config.trouble'.opts end,
  cmd = "Trouble",
  keys = function() return require'plugins.config.trouble'.keys end,
},
{
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter'.setup({
      install_dir = vim.fn.stdpath('data') .. '/TSInstallDir'
    })
    require'plugins.config.treesitter'
  end
},
{
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufEnter",
  opts = function() return require'plugins.config.treesitter-context'.opts end,
},
-- {
--   'kevinhwang91/nvim-ufo',
--   dependencies = 'kevinhwang91/promise-async',
--   opts = function() return require'plugins.config.ufo'.opts end
-- },
{
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
},
-- {
--   "mfussenegger/nvim-lint",
--   enabled = false,
--   config = function()
--     require'plugins.config.lint'
--   end,
-- },
{
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
},
}
