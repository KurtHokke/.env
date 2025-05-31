return {
{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
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
  opts = function()
    return require'pconfig.blink'.opts
  end,
  opts_extend = function()
    return require'pconfig.blink'.opts_extend
  end
},
{
  "folke/trouble.nvim",
  opts = function()
    return require'pconfig.trouble'.opts
  end,
  cmd = "Trouble",
  keys = function()
    return require'pconfig.trouble'.keys
  end
},
{
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  opts = {
    install_dir = vim.fn.stdpath('data') .. '/TSInstallDir'
  },
  config = function()
    require'pconfig.treesitter'
  end
},
{
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
},
}
