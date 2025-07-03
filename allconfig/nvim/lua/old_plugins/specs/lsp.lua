---@module "lazy"
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
  config = function()
    require'plugins.config.mini-pairs'.setup()
  end,
},
{
  'nvimtools/none-ls.nvim',

},
{
  'saghen/blink.cmp',
  event = "VeryLazy",
  dependencies = {
    -- {
    --   "neovim/nvim-lspconfig",
    -- },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      config = function()
        require'plugins.config.luasnip'.config()
      end,
    },
  },
  version = '1.*',
  opts = function() return require'plugins.config.blink'.opts end,
  opts_extend = function() return require'plugins.config.blink'.opts_extend end
},
{
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "saghen/blink.cmp",
    "rachartier/tiny-inline-diagnostic.nvim",
  },
  config = function()
    require'init_lsp'
  end,
},
{
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = function() return require'plugins.config.trouble'.keys end,
  opts = function() return require'plugins.config.trouble'.opts end,
},
{
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter'.setup({
      install_dir = vim.fn.stdpath('data') .. '/TSInstallDir'
    })
    require'plugins.config.treesitter'.config()
  end
},
{
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufEnter",
  opts = function() return require'plugins.config.treesitter-context'.opts end,
},
{
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
},
{
  'mrcjkb/rustaceanvim',
  enabled = false,
  version = '^6', -- Recommended
},
}
