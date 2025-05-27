local M = {}
-- require'pconfig.trouble'
M.opts = {
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = {
    preset = 'none',
    ['<CR>'] = {
      function (cmp)
        if not cmp.is_visible() then return end
        cmp.select_and_accept()
        return true
      end,
      'fallback'
    },
    ['<S-CR>'] = {
      function (cmp)
        if not cmp.is_visible() then return end
        cmp.select_and_accept()
        vim.schedule(function()
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          vim.api.nvim_win_set_cursor(0, {row, col + 1})
        end)
        -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true),'n', false)
        -- vim.api.nvim_feedkeys("l", "i", false)
        return true
      end,
      'fallback'
    },
    ['<Tab>'] = {
      function (cmp)
        if not cmp.is_visible() then return end
        cmp.select_next()
        return true
      end,
      'fallback'
    },
    ['<S-Tab>'] = {
      function (cmp)
        if not cmp.is_visible() then return end
        cmp.select_prev()
        return true
      end,
      'fallback'
    },
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono'
  },

  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    documentation = { auto_show = false },
    list = { selection = {
      -- preselect = false,
      auto_insert = false
    } },
    ghost_text = {
      enabled = true,
    },
  },

  snippets = { preset = 'luasnip' },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --
  -- See the fuzzy documentation for more information
  fuzzy = { implementation = "prefer_rust_with_warning" },

  signature = { enabled = true }
}
M.opts_extend = { "sources.default" }
return M
