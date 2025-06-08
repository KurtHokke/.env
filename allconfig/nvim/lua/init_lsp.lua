local L = {}
local map = vim.keymap.set
local x = vim.diagnostic.severity

L.on_attach = function(_, bufnr)

  require "lsp_signature".on_attach(require'plugins.config.lsp_signature'.opts, bufnr)

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  -- map("n", "<leader>ra", require "configs.lsp_config.renamer", opts "NvRenamer")
end

-- disable semanticTokens
-- L.on_init = function(client, _)
--   if client:supports_method "textDocument/declaration" then
--     client.server_capabilities.declarationProvider = true
--     -- client.server_capabilities.semanticTokensProvider = nil
--   end
-- end
L.capabilities = vim.lsp.protocol.make_client_capabilities()
-- L.capabilities.textDocument.signatureHelp = nil
L.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    L.on_attach(_, args.buf)
    -- L.on_attach(args.data and args.data.client_id and vim.lsp.get_client_by_id(args.data.client_id) or nil, args.buf)
  end,
})
vim.diagnostic.config {
  virtual_text = {
    prefix = "",
  },
  signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
  underline = true,
  -- jump = { wrap = true },
  -- wrap = true,
  float = { border = "single" },
}
vim.lsp.config("*", { capabilities = L.capabilities})--, on_init = L.on_init })

-- local plugin_lua_dirs = {}
-- for _, path in ipairs(vim.fn.glob(vim.fn.stdpath('data') .. '/lazy/*/lua', true, true, true)) do
--   table.insert(plugin_lua_dirs, path)
-- end

vim.lsp.config('lua_ls', {
  on_init = function(client)
    -- if client:supports_method "textDocument/declaration" then
    --   client.server_capabilities.declarationProvider = true
    --   -- client.server_capabilities.semanticTokensProvider = nil
    -- end
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
          vim.env.VIMRUNTIME .. '/lua',
          -- unpack(plugin_lua_dirs),
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library',
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
vim.lsp.enable("lua_ls")
vim.lsp.config('clangd', {
  cmd = {
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
})
vim.lsp.enable("clangd")

vim.filetype.add({
  filename = {
    [".zshrc"] = "zsh",
    [".zshenv"] = "zsh",
  }
})
vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  settings = {
    bashIde = {
      -- Glob pattern for finding and parsing shell script files in the workspace.
      -- Used by the background analysis features across files.

      -- Prevent recursive scanning which will cause issues when opening a file
      -- directly in the home directory (e.g. ~/foo.sh).
      --
      -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command|.zsh)',
    },
  },
  filetypes = { 'bash', 'sh', 'zsh' },
  root_markers = { '.git' },
})
vim.lsp.enable('bashls')

vim.lsp.enable('neocmake')
vim.lsp.enable('jsonls')
-- vim.lsp.config("cmake", {
--   cmd = { vim.fn.stdpath('data') .. '/pyneo/bin/cmake-language-server' },
--   filetypes = { 'cmake', 'CMakeLists.txt' },
--   root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
--   init_options = {
--     buildDirectory = 'build',
--   },
-- })
-- vim.lsp.enable("cmake")

