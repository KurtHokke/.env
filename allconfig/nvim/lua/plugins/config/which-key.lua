local M = {}

M.opts = {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}
M.keys = {
  {
    "<leader>?",
    function()
      require("which-key").show({ global = true })
    end,
    desc = "Buffer Local Keymaps (which-key)",
  },
}

return M
