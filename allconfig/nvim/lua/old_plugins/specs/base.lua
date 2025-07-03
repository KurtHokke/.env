---@module "lazy"
return {
---@class LazySpec
{
  "nvim-tree/nvim-web-devicons", lazy = true, opts = {},
},
{
  'echasnovski/mini.icons', lazy = true, version = false, opts = {},
},
{
  'nvim-lua/plenary.nvim', lazy = false,
},
{
  'KurtHokke/pconf.nvim',
  dev = true,
  build = 'cd src && cmake -B build && cmake --build build && cmake --install build',
  opts = {},
},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function() return require'plugins.config.which-key'.opts end,
  keys = function() return require'plugins.config.which-key'.keys end,
},
{
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
  },
},
{
  "nvim-tree/nvim-tree.lua",
  -- enabled = false,
  -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {'<A-e>'},
  -- opts = function() return require'plugins.config.nvimtree'.opts end,
  config = function() require'plugins.config.nvimtree'.config() end,
},
{
  'mrjones2014/smart-splits.nvim',
  -- lazy = true,
  keys = { '<CS-CR>', '<CA-CR>' },
  build = './kitty/install-kittens.bash',
  opts = {},
  config = function()
    require'plugins.config.smart-splits'.config()
  end
},
{
  'rcarriga/nvim-notify',
  lazy = true,
},
{
  "ibhagwan/fzf-lua",
  keys = { '<leader>rg', 'K' },
  -- lazy = true,
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "echasnovski/mini.icons" },
  opts = function()
    return require'plugins.config.fzf-lua'.opts
  end,
  config = function()
    require'plugins.config.fzf-lua'.config()
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
  event = 'VeryLazy',
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
