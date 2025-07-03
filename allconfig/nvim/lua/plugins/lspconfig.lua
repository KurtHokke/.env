local lsp_signature_opts = {
  debug = false, -- set to true to enable debug logging ---{{{
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  max_height = 12, -- max height of signature floating_window, include borders
  max_width = function()
    local w = vim.api.nvim_win_get_width(0) * 0.8
    return math.floor(w)
  end, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                  -- the value need >= 40
                  -- if max_width is function, it will be called
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
                             -- can be either a number or function
  floating_window_off_y = function(floating_opts) -- adjust float windows y position.
    --e.g. set to -2 can make floating window move up 2 lines
    local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
    local pumheight = vim.o.pumheight
    local winline = vim.fn.winline() -- line number in the window
    local winheight = vim.fn.winheight(0)

    -- window top
    if winline < pumheight then
      return pumheight
    end

    -- window bottom
    if winheight - winline < pumheight then
      return -pumheight
    end
    return 0
  end,
                              -- can be either number or function, see examples
  -- ignore_error = func(err, ctx, config), -- this scilence errors, check init.lua for more details
  ignore_error = function(err, ctx, config) -- provide your ignore callback here
    -- ignore error for some clients
    -- this will also make it a bit harder to track issues
    if ctx and ctx.client_id then
      -- ignore error for some clients
      -- get client name by id
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client and vim.tbl_contains({ 'rust_analyer', 'clangd' }, client.name) then
        return true
      end
    end
    -- other examples:
    -- if err.code_name == 'InvalidParams' then return true end
    -- if err.code_name == 'ContentModified' then return true end
  end,

  -- show_struct = { enable = true },                                   -- experimental: show struct info
  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🔍 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  -- or, provide a table with 3 icons
  -- hint_prefix = {
  --     above = "↙ ",  -- when the hint is on the line above the current line
  --     current = "← ",  -- when the hint is on the same line
  --     below = "↖ "  -- when the hint is on the line below the current line
  -- }
  hint_scheme = "String",
  hint_inline = function() return false end,  -- should the hint be inline(nvim 0.10 only)?  default false
  -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
  -- return 'right_align' to display hint right aligned in the current line
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = 0, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
     -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
     -- may not popup when typing depends on floating_window setting

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_signature_window_key = nil, -- move the floating window, e.g. {'<M-k>', '<M-j>'} to move up and down, or
    -- table of 4 keymaps, e.g. {'<M-k>', '<M-j>', '<M-h>', '<M-l>'} to move up, down, left, right
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating window
  -- e.g. move_cursor_key = '<M-p>',
  -- once moved to floating window, you can use <M-d>, <M-u> to move cursor up and down
  keymaps = {}  -- relate to move_cursor_key; the keymaps inside floating window with arguments of bufnr
  -- e.g. keymaps = function(bufnr) vim.keymap.set(...) end
  -- it can be function that set keymaps
  -- e.g. keymaps = { { 'j', '<C-o>j' }, } this map j to <C-o>j in floating window
  -- <M-d> and <M-u> are default keymaps to move cursor up and down ---}}}
}

return {
{
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "saghen/blink.cmp",
    "rachartier/tiny-inline-diagnostic.nvim",
  },
  config = function()
    --- blink_capabilities
    ---{{{
    -- function sources.get_lsp_capabilities(override, include_nvim_defaults)
    --   return vim.tbl_deep_extend('force', include_nvim_defaults and vim.lsp.protocol.make_client_capabilities() or {}, {
    --     textDocument = {
    --       completion = {
    --         completionItem = {
    --           snippetSupport = true,
    --           commitCharactersSupport = false, -- todo:
    --           documentationFormat = { 'markdown', 'plaintext' },
    --           deprecatedSupport = true,
    --           preselectSupport = false, -- todo:
    --           tagSupport = { valueSet = { 1 } }, -- deprecated
    --           insertReplaceSupport = true, -- todo:
    --           resolveSupport = {
    --             properties = {
    --               'documentation',
    --               'detail',
    --               'additionalTextEdits',
    --               'command',
    --               'data',
    --               -- todo: support more properties? should test if it improves latency
    --             },
    --           },
    --           insertTextModeSupport = {
    --             -- todo: support adjustIndentation
    --             valueSet = { 1 }, -- asIs
    --           },
    --           labelDetailsSupport = true,
    --         },
    --         completionList = {
    --           itemDefaults = {
    --             'commitCharacters',
    --             'editRange',
    --             'insertTextFormat',
    --             'insertTextMode',
    --             'data',
    --           },
    --         },
    --
    --         contextSupport = true,
    --         insertTextMode = 1, -- asIs
    --       },
    --     },
    --   }, override or {})
    -- end
    ---}}}

    local function on_attach(_, bufnr)
      require "lsp_signature".on_attach(lsp_signature_opts, bufnr)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        on_attach(_, args.buf)
      end,
    })

    vim.lsp.config('lua_ls', {
      on_init = function(client) ---{{{
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              'lua/?.lua',
              'lua/?/init.lua',
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    }) ---}}}
    vim.lsp.enable("lua_ls")
    -- vim.lsp.enable('emmylua_ls')

    vim.lsp.config('clangd', {
      cmd = { ---{{{
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders=false",
        -- "--fallback-style=llvm",
      },
      root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac', -- AutoTools
        '.git',
      },
      capabilities = vim.tbl_deep_extend('force', vim.lsp.config["*"].capabilities, {
        textDocument = {
          completion = {
            editsNearCursor = true,
          },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
      }),
    }) ---}}}
    vim.lsp.enable("clangd")

    vim.lsp.enable('jsonls')
    vim.lsp.enable('neocmake')


    --- lsp/lua_ls.lua
    ---{{{
    -- vim.lsp.config('lua_ls', {
    --   on_init = function(client)
    --     if client.workspace_folders then
    --       local path = client.workspace_folders[1].name
    --       if
    --         path ~= vim.fn.stdpath('config')
    --         and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
    --       then
    --         return
    --       end
    --     end
    --
    --     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
    --       runtime = {
    --         -- Tell the language server which version of Lua you're using (most
    --         -- likely LuaJIT in the case of Neovim)
    --         version = 'LuaJIT',
    --         -- Tell the language server how to find Lua modules same way as Neovim
    --         -- (see `:h lua-module-load`)
    --         path = {
    --           'lua/?.lua',
    --           'lua/?/init.lua',
    --         },
    --       },
    --       -- Make the server aware of Neovim runtime files
    --       workspace = {
    --         checkThirdParty = false,
    --         library = {
    --           vim.env.VIMRUNTIME
    --           -- Depending on the usage, you might want to add additional paths
    --           -- here.
    --           -- '${3rd}/luv/library'
    --           -- '${3rd}/busted/library'
    --         }
    --         -- Or pull in all of 'runtimepath'.
    --         -- NOTE: this is a lot slower and will cause issues when working on
    --         -- your own configuration.
    --         -- See https://github.com/neovim/nvim-lspconfig/issues/3189
    --         -- library = {
    --         --   vim.api.nvim_get_runtime_file('', true),
    --         -- }
    --       }
    --     })
    --   end,
    --   settings = {
    --     Lua = {}
    --   }
    -- })
    --- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
    --- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
    --- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)
    ---
    -- return {
    --   cmd = { 'lua-language-server' },
    --   filetypes = { 'lua' },
    --   root_markers = {
    --     '.luarc.json',
    --     '.luarc.jsonc',
    --     '.luacheckrc',
    --     '.stylua.toml',
    --     'stylua.toml',
    --     'selene.toml',
    --     'selene.yml',
    --     '.git',
    --   },
    -- }
    ---}}}
    --- lsp/emmylua_ls.lua
    ---{{{
    -- return {
    --   cmd = { 'emmylua_ls' },
    --   filetypes = { 'lua' },
    --   root_markers = {
    --     '.luarc.json',
    --     '.emmyrc.json',
    --     '.luacheckrc',
    --     '.git',
    --   },
    --   workspace_required = false,
    -- }
    ---}}}
    --- lsp/clangd.lua
    ---{{{
    -- local function switch_source_header(bufnr)
    --   local method_name = 'textDocument/switchSourceHeader'
    --   local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
    --   if not client then
    --     return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
    --   end
    --   local params = vim.lsp.util.make_text_document_params(bufnr)
    --   client.request(method_name, params, function(err, result)
    --     if err then
    --       error(tostring(err))
    --     end
    --     if not result then
    --       vim.notify('corresponding file cannot be determined')
    --       return
    --     end
    --     vim.cmd.edit(vim.uri_to_fname(result))
    --   end, bufnr)
    -- end
    --
    -- local function symbol_info()
    --   local bufnr = vim.api.nvim_get_current_buf()
    --   local clangd_client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
    --   if not clangd_client or not clangd_client.supports_method 'textDocument/symbolInfo' then
    --     return vim.notify('Clangd client not found', vim.log.levels.ERROR)
    --   end
    --   local win = vim.api.nvim_get_current_win()
    --   local params = vim.lsp.util.make_position_params(win, clangd_client.offset_encoding)
    --   clangd_client.request('textDocument/symbolInfo', params, function(err, res)
    --     if err or #res == 0 then
    --       -- Clangd always returns an error, there is not reason to parse it
    --       return
    --     end
    --     local container = string.format('container: %s', res[1].containerName) ---@type string
    --     local name = string.format('name: %s', res[1].name) ---@type string
    --     vim.lsp.util.open_floating_preview({ name, container }, '', {
    --       height = 2,
    --       width = math.max(string.len(name), string.len(container)),
    --       focusable = false,
    --       focus = false,
    --       border = 'single',
    --       title = 'Symbol Info',
    --     })
    --   end, bufnr)
    -- end
    --
    -- ---@class ClangdInitializeResult: lsp.InitializeResult
    -- ---@field offsetEncoding? string
    --
    -- return {
    --   cmd = { 'clangd' },
    --   filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    --   root_markers = {
    --     '.clangd',
    --     '.clang-tidy',
    --     '.clang-format',
    --     'compile_commands.json',
    --     'compile_flags.txt',
    --     'configure.ac', -- AutoTools
    --     '.git',
    --   },
    --   capabilities = {
    --     textDocument = {
    --       completion = {
    --         editsNearCursor = true,
    --       },
    --     },
    --     offsetEncoding = { 'utf-8', 'utf-16' },
    --   },
    --   ---@param client vim.lsp.Client
    --   ---@param init_result ClangdInitializeResult
    --   on_init = function(client, init_result)
    --     if init_result.offsetEncoding then
    --       client.offset_encoding = init_result.offsetEncoding
    --     end
    --   end,
    --   on_attach = function()
    --     vim.api.nvim_buf_create_user_command(0, 'LspClangdSwitchSourceHeader', function()
    --       switch_source_header(0)
    --     end, { desc = 'Switch between source/header' })
    --
    --     vim.api.nvim_buf_create_user_command(0, 'LspClangdShowSymbolInfo', function()
    --       symbol_info()
    --     end, { desc = 'Show symbol info' })
    --   end,
    -- }
    ---}}}
    --- lsp/pkgbuild_language_server.lua
    ---{{{
    ---@brief
    ---
    --- https://github.com/Freed-Wu/pkgbuild-language-server
    ---
    --- Language server for ArchLinux/Windows Msys2's PKGBUILD.
    -- return {
    --   cmd = { 'pkgbuild-language-server' },
    --   filetypes = { 'PKGBUILD' },
    --   root_markers = { '.git' },
    -- }
    ---}}}
  end,
},
}
