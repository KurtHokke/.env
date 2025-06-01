return {
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require'tokyonight'.setup({
      style = "night",
      on_highlights = function(hl, c)
        hl.BlinkCmpMenuBorder = { fg = "#00cb00" }
      end
    })
  end
},
}
