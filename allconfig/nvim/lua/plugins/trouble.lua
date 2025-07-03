return {
{
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
  {
    "<leader>hh",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Buffer Diagnostics (Trouble)",
  },
  {
    "<leader>hH",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Diagnostics (Trouble)",
  },
  {
    "<leader>cs",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    desc = "Symbols (Trouble)",
  },
  -- {
  --   "<leader>cl",
  --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --   desc = "LSP Definitions / references / ... (Trouble)",
  -- },
  -- {
  --   "<leader>hL",
  --   "<cmd>Trouble loclist toggle<cr>",
  --   desc = "Location List (Trouble)",
  -- },
  -- {
  --   "<leader>hQ",
  --   "<cmd>Trouble qflist toggle<cr>",
  --   desc = "Quickfix List (Trouble)",
  -- },
  },
  opts = {},
},
}
