return {
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      -- ...
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", opts = { ensure_installed = { "clangd" } } },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local map = vim.keymap.set
      lspconfig.clangd.setup({
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu", "--completion-style=detailed" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        root_dir = lspconfig.util.root_pattern(
          "Makefile", "configure.ac", "configure.in", "config.h.in",
          "meson.build", "meson_options.txt", "build.ninja",
          "compile_commands.json", "compile_flags.txt"
        ),
        capabilities = { offsetEncoding = { "utf-16" } },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })
    -- LSP actions
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
    -- Clangd-specific
      map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", { desc = "Switch Source/Header" })
      map("n", "<leader>cs", "<cmd>ClangdSymbolInfo<CR>", { desc = "Symbol Info" })
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = { inline = false },
        ast = { role_icons = {}, kind_icons = {} }, -- Customize if needed
      })
    end,
  },
}
