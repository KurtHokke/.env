return {
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
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
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    require'tokyonight'.setup({
      style = "night",
      light_style = "day", -- The theme is used when the background is set to light
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      dim_inactive = false, -- dims inactive windows
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

      plugins = {},
      cache = true,
      on_colors = function (colors)
      end,

      on_highlights = function (hl, c)
        require'options.highlight'.tokyonight(hl, c)
      end,
    })
  end
},
}
