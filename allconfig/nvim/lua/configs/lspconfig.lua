require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  bashls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true), -- Include Neovim runtime files
          checkThirdParty = false, -- Avoid third-party library prompts
        },
      },
    },
  },
  clangd = {},
  -- pyright = {
    -- settings = {
      -- python = {
        -- analysis = {
          -- autoSearchPaths = true,
          -- typeCheckingMode = "basic",
        -- },
      -- },
    -- },
  -- },
}

for name, opts in pairs(servers) do
  require("lspconfig")[name].setup(opts)
end

-- read :h vim.lsp.config for changing options of lsp servers 
