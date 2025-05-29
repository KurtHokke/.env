return {
{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
},
{
  'saghen/blink.cmp',
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("init_lsp")
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      build = "make install_jsregexp",
      opts = {},
      config = function()
        require("pconfig.luasnip")
      end,
    },
    'rafamadriz/friendly-snippets'
  },
  version = '1.*',
  opts = require'pconfig.blink'.opts,
  opts_extend = require'pconfig.blink'.opts_extend,
},
{
  "folke/trouble.nvim",
  opts = require'pconfig.trouble'.opts, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = require'pconfig.trouble'.keys
},
{
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  opts = require'pconfig.treesitter'.opts,
},
{
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
},
}
