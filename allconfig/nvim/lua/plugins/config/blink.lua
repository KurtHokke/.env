
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
      },
      auto_show = function(ctx)
        if M.str_in_list(vim.treesitter.get_captures_at_cursor(), "string") then
          local pos = vim.api.nvim_win_get_cursor(0)
          local linetext = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)
          if string.match(linetext[1], "event") then
            log('found event in line')
            return true
          end
          log(linetext[1], {raw = true})
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
    default = { 'lazydev', 'lsp', 'path', 'snippets' }, --'emoji', 'nerdfont' },
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
      -- emoji = {
      --   module = "blink-emoji",
      --   name = "Emoji",
      --   score_offset = 15, -- Tune by preference
      --   opts = {
      --     insert = true, -- Insert emoji (default) or complete its name
      --     ---@type string|table|fun():table
      --     trigger = function()
      --       return { ">" }
      --     end,
      --   },
      -- },
      -- nerdfont = {
      --   module = "blink-nerdfont",
      --   name = "Nerd Fonts",
      --   score_offset = 15, -- Tune by preference
      --   opts = {
      --     insert = true, -- Insert nerdfont icon (default) or complete its name
      --   },
      -- },
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
}
M.opts_extend = { "sources.default" }
return M
