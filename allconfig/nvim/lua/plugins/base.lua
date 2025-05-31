return {
{
  "nvim-tree/nvim-web-devicons", lazy = true, opts = {},
},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = require'pconfig.which-key'.opts,
  keys = require'pconfig.which-key'.keys,
},
{
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = function()
    return require("pconfig.nvimtree").config
  end,
},
{
  'rcarriga/nvim-notify',
  lazy = true,
},
{
  'nvim-telescope/telescope.nvim',
  cmd = { 'Telescope' },
  tag = '0.1.8',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = require'pconfig.telescope'.opts
},
{
  'akinsho/bufferline.nvim',
  event = "BufEnter",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = require'pconfig.bufferline'.opts,
},
{
  'uga-rosa/ccc.nvim',
  cmd = { 'CccHighlighterEnable', 'CccPick' },
  config = function ()
    require'pconfig.ccc'.config()
  end
},
}
