local M = {}

function M.config()
  local map = vim.keymap.set
  -- local rs = {
  --   remap = true,
  --   silent = true,
  -- }
  local nrs = {
    noremap = true,
    silent = true,
  }
  map('n', 'K', '<Nop>', nrs)
  map('n', 'K', '<CMD>FzfLua lsp_finder<CR>', nrs)
  map('n', '<leader>rg', '<CMD>FzfLua live_grep_glob<CR>', nrs)
end

-- local actions = require("fzf-lua").actions

---@module "fzf-lua"
M.opts = {
  'fzf-native',
  keymap = {
    -- Below are the default binds, setting any value in these tables will override
    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
    fzf = {
      ["alt-j"] = "preview-down",
      ["alt-k"] = "preview-up",
    },
  },
}


-- map('t', '<A-j>', '<Down>', rs)
-- map('t', '<A-k>', '<Up>', rs)

return M
