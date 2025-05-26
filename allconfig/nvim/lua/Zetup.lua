local Z = {}

function Z.colorscheme()
  require('onedark').setup {
    style = 'darker'
  }
  require('onedark').load()
end

Z.yazi = {
  deps = {
    -- check the installation instructions at
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    -- {
    --   "<A-e>",
    --   mode = { "n", "v" },
    --   "<cmd>Yazi<cr>",
    --   desc = "Open yazi at the current file",
    -- },
    -- {
    --   -- Open in the current working directory
    --   "<A-e>",
    --   mode = { "n", "v" },
    --   "<cmd>Yazi cwd<cr>",
    --   desc = "Open the file manager in nvim's working directory",
    -- },
    {
      "<A-e>",
      mode = { "n", "v" },
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    -- init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      -- vim.g.loaded_netrwPlugin = 1
    -- end,
  },
}

Z.lualine = {
  deps = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}

return Z
