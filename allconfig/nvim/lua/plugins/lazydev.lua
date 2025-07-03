return {
{
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- { path = "ccc.nvim", mods = { "ccc" } },
      { path = "/home/src/.env/allconfig/.local/nvim/lazy/lazy.nvim/lua/lazy", mods = { "lazy" } },
      { path = "fzf-lua", mods = { "fzf-lua" } },
    }
  },
},
}
