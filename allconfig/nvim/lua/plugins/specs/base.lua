---@module "lazy"
return 
---@class LazyPlugin
{
  "nvim-tree/nvim-web-devicons", lazy = true, opts = {}, event
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
  lazy = true,
  -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  -- keys = {'<A-e>'},
  opts = function() return require'plugins.config.nvimtree'.config end,
},
{
  'mrjones2014/smart-splits.nvim',
  -- lazy = true,
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
  "ibhagwan/fzf-lua",
  -- lazy = true,
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
  -- lazy = true,
  cmd = "GrugFar",
  keys = function() return require'plugins.config.grug-far'.keys end,
  opts = { headerMaxWidth = 80 },
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
  enabled = false,
  lazy = true,
  version = false,
  opts = {},
},
}
