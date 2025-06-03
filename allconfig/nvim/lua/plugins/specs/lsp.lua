return {
{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
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
      "moyiz/blink-emoji.nvim",
      "MahanRahmati/blink-nerdfont.nvim",
    },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      build = "make install_jsregexp",
      opts = {},
      config = function()
        require'plugins.config.luasnip'
      end,
    },
    'rafamadriz/friendly-snippets'
  },
  version = '1.*',
  opts = function()
    return require'plugins.config.blink'.opts
  end,
  opts_extend = function()
    return require'plugins.config.blink'.opts_extend
  end
},
{
  "folke/trouble.nvim",
  opts = function()
    return require'plugins.config.trouble'.opts
  end,
  cmd = "Trouble",
  keys = function()
    return require'plugins.config.trouble'.keys
  end
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
