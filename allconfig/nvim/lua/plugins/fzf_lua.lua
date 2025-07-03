return {
{
  "ibhagwan/fzf-lua",
  keys = { '<leader>rg', 'K' },
  -- lazy = true,
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    'fzf-native',
    keymap = {
      -- Below are the default binds, setting any value in these tables will override
      -- the defaults, to inherit from the defaults change [1] from `false` to `true`
      fzf = {
        ["alt-j"] = "preview-down",
        ["alt-k"] = "preview-up",
      },
    },
  },
  config = function()
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
},
}
