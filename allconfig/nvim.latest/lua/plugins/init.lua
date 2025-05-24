return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function(_, conf)
      local ensure_installed = {"html", "css", "bash", "c", "cmake"}
      return vim.tbl_deep_extend("force", conf, {
        ensure_installed = ensure_installed,
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, conf)
-- Define custom on_attach
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")
        local function map_opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- Load default mappings
        api.config.mappings.default_on_attach(bufnr)
        -- Override 'e' to collapse directory
        vim.keymap.set("n", "e", api.node.open.edit, map_opts("Open File Or Folder"))
      end
      -- Merge with NvChad's defaults
      return vim.tbl_deep_extend("force", conf, {
        on_attach = my_on_attach,
        -- Optional: Keep other settings
        view = { width = 20 },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "p00f/clangd_extensions.nvim",
        opts = {
          inlay_hints = { enabled = true },
        },
      },
    },
    opts = function()
      local servers = {
        html = {},
        cssls = {},
        cmake = {},
        bashls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
            },
          },
        },
        clangd = {
          keys = {
            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = { offsetEncoding = { "utf-16" } },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      }
      local setup = {
        clangd = function(_, server_opts)
          local clangd_ext_opts = { inlay_hints = { enabled = true } }
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts, { server = server_opts }))
          return false
        end,
      }
      return {
        servers = servers,
        setup = setup,
      }
    end,
    config = function(_, opts)
      require("nvchad.configs.lspconfig").defaults()
      for name, server_opts in pairs(opts.servers or {}) do
        if opts.setup and type(opts.setup[name]) == "function" then
          opts.setup[name](nil, server_opts)
        else
          require("lspconfig")[name].setup(server_opts)
        end
      end
    end,
  },
  -- test new blink
  { import = "nvchad.blink.lazyspec" },
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
        require('tiny-inline-diagnostic').setup()
        vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end
  },
}
