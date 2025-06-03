local M = {}

function M.mapping()
  local map = vim.keymap.set
  local nrs = {
    noremap = true,
    silent = true,
  }
  -- map('n', '<leader>ccc', '<CMD>execute "CccHighlighterEnable" | CccPick<CR>', nrs)
  map({'n', 'i'}, '<A-c>', '<CMD>CccPick<CR><ESC>', nrs)
end

function M.config()
  local ccc = require'ccc'
  local mapping = ccc.mapping
  ccc.setup({
	  highlighter = {
	    auto_enable = true,
	    lsp = true,
	  },
    mappings = {
      ['<A-l>'] = mapping.increase10,
      ['<A-h>'] = mapping.decrease10,
      e = mapping.complete
    },
    highlight_mode = "virtual",

  })
  -- vim.api.nvim_command('CccHighlighterEnable')
end

return M
