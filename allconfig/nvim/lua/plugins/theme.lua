return {
-- {
--   "navarasu/onedark.nvim",
--   priority = 1000,
--   config = function()
--     require('onedark').setup {
--       style = 'darker'
--     }
--     require('onedark').load()
--   end,
-- },
-- {
--   "ellisonleao/gruvbox.nvim",
--   priority = 1000,
--   config = function()
--     vim.o.background = "dark" -- or "light" for light mode
--     require'pconfig.gruvbox'.opts()
--     vim.cmd([[colorscheme gruvbox]])
--     return true
--   end,
-- },
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
},
}
