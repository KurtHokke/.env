require("nvchad.configs.lspconfig").defaults()
require("lspconfig").clangd.setup{}
local servers = { "html", "cssls", "clangd" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
