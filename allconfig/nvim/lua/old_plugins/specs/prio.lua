return {
{
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  opts = function()
    return require'plugins.config.t_i_d'.opts
  end
},
{
  "folke/snacks.nvim",
  priority = 999,
  lazy = false,
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = false },
  },
},
{
  "vhyrro/luarocks.nvim",
  enabled = false,
  lazy = true,
  -- priority = 1000, -- Very high priority to ensure it loads first
  -- opts = {},
},
}
