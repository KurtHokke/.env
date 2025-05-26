return {
{
  "nvim-tree/nvim-web-devicons", lazy = true, opts = {},
},
{
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require("Zetup").colorscheme()
  end,
},
{
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = require("Zetup").yazi.deps,
  keys = require("Zetup").yazi.keys,
  opts = require("Zetup").yazi.opts,
},
{
    "nvim-lualine/lualine.nvim",
    dependencies = require("Zetup").lualine.deps,
    opts = require("Zetup").lualine.opts,
},
}
