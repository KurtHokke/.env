return {
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

      plugins = {
        auto = true,
      },
      cache = true,
      -- on_colors = function (colors)
      -- end,

      on_highlights = function (hl, c)
        hl.BlinkCmpMenuBorder = { fg = "#00cb00" }
        hl.NvimTreeFolderIcon = { fg = "#ffc500", bg = c.none }
      end,
    })
    vim.cmd[[colorscheme tokyonight]]
  end
},
}
