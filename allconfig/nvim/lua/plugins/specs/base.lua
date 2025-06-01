return {
{
  "nvim-tree/nvim-web-devicons", lazy = true, opts = {},
},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function()
    return require'pconfig.which-key'.opts
  end,
  keys = function()
    return require'pconfig.which-key'.keys
  end,
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
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
  },
  opts = function()
    return require'pconfig.telescope'.opts
  end,
},
{
  'akinsho/bufferline.nvim',
  event = "BufEnter",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = function()
    return require'pconfig.bufferline'.opts
  end,
},
{
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require'pconfig.lualine'.Bubbles()
  end
},
{
  'uga-rosa/ccc.nvim',
  cmd = { 'CccHighlighterEnable', 'CccPick' },
  config = function ()
    require'pconfig.ccc'.config()
  end
},
}
