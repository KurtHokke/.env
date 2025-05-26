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
-- {
--   "romgrk/barbar.nvim",
--   event = Z.barbar.event,
--   dependencies = Z.barbar.deps,
--   init = function()
--     Z.barbar.init()
--   end,
--   opts = Z.barbar.opts,
-- },
}
