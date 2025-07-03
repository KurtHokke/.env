
local M = {}
local log = require'functions.logger'.log
---@module "blink-cmp"

M.str_in_list = require'functions.string'.str_in_list
M.opts = {

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono'
  },
  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    menu = {
      winblend = 0,
      scrollbar = false,
      border = 'single',
      draw = {
        padding = 0,
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" }
        },
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
          kind = {
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
        },
      },
      auto_show = function(ctx)
        if M.str_in_list(vim.treesitter.get_captures_at_cursor(), "string") then
          return false
        else
          return true
        end
      end,
      cmdline_position = function()
        if vim.g.ui_cmdline_pos ~= nil then
          local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
          return { pos[1], pos[2] }
        end
        log("vim.g.ui_cmdline_pos == nil /blink.cmp", {level = vim.log.levels.ERROR, timeout = false})
        return {0, 0}
      end,
    },
    documentation = { auto_show = false },
    list = { selection = { auto_insert = false }},
    ghost_text = { enabled = true },
    accept = { auto_brackets = { enabled = true }},
  },

  snippets = { preset = 'luasnip' },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    -- default = { 'lazydev', 'lsp', 'path', 'snippets' },
    default = function(ctx)
      local success, node = pcall(vim.treesitter.get_node)
      local sources = {}
      if success and node then
        if vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
          return { 'buffer' }
        elseif vim.tbl_contains({ 'string' }, node:type()) then
          sources = { 'lazydev', 'lsp', 'path', 'buffer' }
        else
          sources = { 'lazydev', 'lsp', 'path', 'snippets' }
        end
      else
        sources = { 'lazydev', 'lsp', 'path', 'snippets' }
      end
      if vim.bo.filetype ~= 'lua' then
        table.remove(sources, 1)
      end
      return sources
    end,
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
      snippets = {
        module = 'blink.cmp.sources.snippets',
        score_offset = 10,
        should_show_items = function(ctx)
          return ctx.trigger.initial_kind ~= 'trigger_character'
        end
      },
    },
  },

  -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --
  -- See the fuzzy documentation for more information
  fuzzy = { implementation = "prefer_rust_with_warning" },

  signature = { enabled = false },

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
        if not cmp.is_visible() then
          if require'luasnip'.expand_or_jumpable() then
            vim.schedule(function()
              require'luasnip'.expand_or_jump()
            end)
            return true
          end
          return
        end
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
}
M.opts_extend = { "sources.default" }
return M
