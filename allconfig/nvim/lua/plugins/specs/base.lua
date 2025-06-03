return {
{
  "nvim-tree/nvim-web-devicons", lazy = true, opts = {},
},
{
  'echasnovski/mini.icons', lazy = true, version = false, opts = {},
},
{
  'nvim-lua/plenary.nvim', lazy = true,
},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function() return require'plugins.config.which-key'.opts end,
  keys = function() return require'plugins.config.which-key'.keys end,
},
{
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = function() return require'plugins.config.nvimtree'.config end,
},
{
  'mrjones2014/smart-splits.nvim',
  lazy = true,
  keys = { '<CS-CR>', '<CA-CR>' },
  build = './kitty/install-kittens.bash',
  opts = {},
  config = function()
    require'plugins.config.smart-splits'
  end
},
{
  'rcarriga/nvim-notify',
  lazy = true,
},
{
  'nvim-telescope/telescope.nvim',
  enabled = false,
  cmd = { 'Telescope' },
  keys = { '<leader>rg' },
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = '/usr/local/cmake-3.31.7/bin/cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && /usr/local/cmake-3.31.7/bin/cmake --build build --config Release',
    },
  },
  opts = function() return require'plugins.config.telescope'.opts end,
  config = function()
    require'plugins.config.telescope'.after()
  end,
},
{
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  init = function()
    require'plugins.config.fzf-lua'
  end
},
{
  'akinsho/bufferline.nvim',
  event = "BufEnter",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = function() return require'plugins.config.bufferline'.opts end,
},
{
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function() return require'plugins.config.lualine'.config end,
},
{
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = function() return require'plugins.config.noice'.opts end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
},
{
  "MagicDuck/grug-far.nvim",
  opts = { headerMaxWidth = 80 },
  cmd = "GrugFar",
  keys = function() return require'plugins.config.grug-far'.keys end,
},
{
  'uga-rosa/ccc.nvim',
  cmd = { 'CccHighlighterEnable', 'CccPick' },
  config = function ()
    require'plugins.config.ccc'.config()
  end
},
{
  'echasnovski/mini.doc',
  lazy = true,
  version = false,
  opts = {},
},
}
