return {
{
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("init_lsp")
      end,
    },
    'rafamadriz/friendly-snippets'
  },
  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',
  opts = require'pconfig.blink'.opts,
  opts_extend = require'pconfig.blink'.opts_extend,
},
-- {
--   "neovim/nvim-lspconfig",
--   lazy = false,
--   dependencies = {
--     -- main one
--     { "ms-jpq/coq_nvim", branch = "coq" },
--     -- 9000+ Snippets
--     { "ms-jpq/coq.artifacts", branch = "artifacts" },
--     -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
--     -- Need to **configure separately**
--     { 'ms-jpq/coq.thirdparty', branch = "3p" }
--     -- - shell repl
--     -- - nvim lua api
--     -- - scientific calculator
--     -- - comment banner
--     -- - etc
--   },
--   init = function()
--     vim.g.coq_settings = {
--       auto_start = false,
--       keymap = { recommended = false, },
--       completion = {
--         skip_after = {'["{", "}", "[", "]"]'},
--       },
--     }
--     vim.api.nvim_set_keymap('i', '<Esc>', [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]], { expr = true, silent = true })
--     vim.api.nvim_set_keymap('i', '<C-c>', [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]], { expr = true, silent = true })
--     vim.api.nvim_set_keymap('i', '<BS>', [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]], { expr = true, silent = true })
--     vim.api.nvim_set_keymap(
--       "i",
--       "<CR>",
--       [[pumvisible() ? (complete_info().selected == -1 ? "\<Tab><C-y>" : "\<C-y>") : "\<CR>"]],
--       -- [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
--       { expr = true, silent = true }
--     )
--     vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = true })
--     vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<BS>"]], { expr = true, silent = true })
--   end,
--   config = function()
--     require("init_lsp")
--   end,
-- },
{
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  opts = {
    install_dir = vim.fn.stdpath('data') .. '/site'
  },
  config = function()
    require("pconfig.treesitter").install()
  end,
},

-- {
--   'hrsh7th/nvim-cmp',
--   dependencies = {
--     'hrsh7th/cmp-nvim-lsp',
--     'hrsh7th/cmp-buffer',
--     'hrsh7th/cmp-path',
--     'L3MON4D3/LuaSnip',
--     'saadparwaiz1/cmp_luasnip',
--   },
-- },
}
