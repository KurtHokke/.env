return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd" }, -- Automatically install clangd
      })

      -- LSP server setup for clangd
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_dir = lspconfig.util.root_pattern(
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          ".git"
        ),
        settings = {
          clangd = {
            fallbackFlags = { "-std=gnu11" }, -- Fallback if compile_commands.json is missing
          },
        },
      })

      -- Keybindings for LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show hover information
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Find references
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts) -- Show diagnostics
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- Load plugin when entering insert mode
    opts = {}, -- Use default configuration
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- Optional: Integrate with nvim-cmp for completion confirmation
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded"
      }
    },
    -- or use config
    -- config = function(_, opts) require'lsp_signature'.setup({you options}) end
  },
  {
    "rmagatti/logger.nvim",
  },
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    opts = {
      vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true}),
      vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", {noremap=true})
    }
  },
  {
    "Kasama/nvim-custom-diagnostic-highlight",
    config = function()
      require("nvim-custom-diagnostic-highlight").setup {}
    end
  },
}

