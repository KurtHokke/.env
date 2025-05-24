local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")

lspconfig.servers = {
  "lua_ls"
}
local default_servers = {
  "clangd"
}

for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end
--   html = {},
--   cssls = {},
--   bashls = {},
--   lua_ls = {
--     settings = {
--       Lua = {
--         diagnostics = {
--           globals = { 'vim' },
--         },
--         workspace = {
--           library = vim.api.nvim_get_runtime_file('', true), -- Include Neovim runtime files
--           checkThirdParty = false, -- Avoid third-party library prompts
--         },
--       },
--     },
--   },
--   clangd = {
--     keys = {
--       { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
--     },
--     root_dir = function(fname)
--       return require("lspconfig.util").root_pattern(
--         "Makefile",
--         "configure.ac",
--         "configure.in",
--         "config.h.in",
--         "meson.build",
--         "meson_options.txt",
--         "build.ninja"
--       )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
--         fname
--       ) or require("lspconfig.util").find_git_ancestor(fname)
--     end,
--     capabilities = {
--       offsetEncoding = { "utf-16" },
--     },
--     cmd = {
--       "clangd",
--       "--background-index",
--       "--clang-tidy",
--       "--header-insertion=iwyu",
--       "--completion-style=detailed",
--       "--function-arg-placeholders",
--       "--fallback-style=llvm",
--     },
--     init_options = {
--       usePlaceholders = true,
--       completeUnimported = true,
--       clangdFileStatus = true,
--     },
--   },
--   -- pyright = {
--     -- settings = {
--       -- python = {
--         -- analysis = {
--           -- autoSearchPaths = true,
--           -- typeCheckingMode = "basic",
--         -- },
--       -- },
--     -- },
--   -- },
-- }
--
-- for name, opts in pairs(servers) do
--   require("lspconfig")[name].setup(opts)
-- end
--
-- read :h vim.lsp.config for changing options of lsp servers 
