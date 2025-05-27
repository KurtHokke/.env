return {
{
  "nvim-tree/nvim-web-devicons", lazy = true, opts = {},
},
{
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'darker'
    }
    require('onedark').load()
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
  "romgrk/barbar.nvim",
  event = "BufReadPost",
  dependencies = { 'nvim-tree/nvim-web-devicons', },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {},
},
}
