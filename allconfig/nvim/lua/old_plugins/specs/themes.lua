return {
{
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  enabled = false,
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    -- options = {
    --   -- Compiled file's destination location
    --   compile_path = vim.fn.stdpath('cache') .. '/github-theme',
    --   compile_file_suffix = '_compiled', -- Compiled file suffix
    --   hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
    --   hide_nc_statusline = true, -- Override the underline style for non-active statuslines
    --   transparent = false,       -- Disable setting bg (make neovim's background transparent)
    --   terminal_colors = true,    -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    --   dim_inactive = false,      -- Non focused panes set to alternative background
    --   module_default = true,     -- Default enable value for modules
    --   styles = {                 -- Style to be applied to different syntax groups
    --     comments = 'NONE',       -- Value is any valid attr-list value `:help attr-list`
    --     functions = 'NONE',
    --     keywords = 'NONE',
    --     variables = 'NONE',
    --     conditionals = 'NONE',
    --     constants = 'NONE',
    --     numbers = 'NONE',
    --     operators = 'NONE',
    --     strings = 'NONE',
    --     types = 'NONE',
    --   },
    --   inverse = {                -- Inverse highlight for different types
    --     match_paren = false,
    --     visual = false,
    --     search = false,
    --   },
    --   darken = {                 -- Darken floating windows and sidebar-like windows
    --     floats = true,
    --     sidebars = {
    --       enable = true,
    --       list = {},             -- Apply dark background to specific windows
    --     },
    --   },
    --   modules = {                -- List of various plugins and additional options
    --     -- ...
    --   },
    -- },
    -- palettes = {},
    -- specs = {},
    -- groups = {},
  },
  config = function()
    -- require('github-theme').setup({
    --   -- ...
    -- })

    vim.cmd('colorscheme github_dark_default')
  end,
},
{
  "folke/tokyonight.nvim",
  enabled = true,
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
      on_colors = function (colors)
      end,

      on_highlights = function (hl, c)
        require'options.highlight'.tokyonight(hl, c)
      end,
    })
    vim.cmd[[colorscheme tokyonight]]
  end
},
{
  'rebelot/kanagawa.nvim',
  enabled = false,
  lazy = true,
  opts = {
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "wave",              -- Load "wave" theme
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
  },
},
{
  "oxfist/night-owl.nvim",
  enabled = false,
  lazy = true,
  opts = {},
},
{
  "catppuccin/nvim",
  enabled = false,
  name = "catppuccin",
},
}
