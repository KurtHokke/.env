local Z = require("Zetup")

return {
{
  "nvim-tree/nvim-web-devicons", lazy = true, opts = {},
},
{
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    Z.colorscheme()
  end,
},
{
  "mikavilpas/yazi.nvim",
  event = Z.yazi.event,
  dependencies = Z.yazi.deps,
  keys = Z.yazi.keys,
  opts = Z.yazi.opts,
},
{
  "romgrk/barbar.nvim",
  event = Z.barbar.event,
  dependencies = Z.barbar.deps,
  init = function()
    Z.barbar.init()
  end,
  opts = Z.barbar.opts,
},
{
  "nvim-lualine/lualine.nvim",
  dependencies = Z.lualine.deps,
  opts = Z.lualine.opts,
},
{
  "nvim-treesitter/nvim-treesitter",
  event = Z.treesitter.event,
  cmd = Z.treesitter.cmd,
  build = Z.treesitter.build,
  opts = Z.treesitter.opts,
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
},
-- {
--   "windwp/nvim-autopairs",
--   event = Z.autopairs.event,
--   config = Z.autopairs.config,
--   opts = Z.autopairs.opts,
-- },
{
  "neovim/nvim-lspconfig",
  lazy = Z.lsp_config.lazy,
  dependencies = Z.lsp_config.deps,
  opts = Z.lsp_config.opts,
},

-- {
--   "ray-x/guihua.lua",
--   lazy = true,
--   build = "cd lua/fzy && make",
--   opts = Z.guihua.opts,
-- },
-- {
--   "ray-x/navigator.lua",
--   dependencies = Z.navigator.deps,
--   opts = Z.navigator.opts,
-- },
-- {
--   "p00f/clangd_extensions.nvim",
--   lazy = true,
--   config = function() end,
--   opts = {
--     inlay_hints = {
--       inline = false,
--     },
--     ast = {
--       --These require codicons (https://github.com/microsoft/vscode-codicons)
--       role_icons = {
--         type = "",
--         declaration = "",
--         expression = "",
--         specifier = "",
--         statement = "",
--         ["template argument"] = "",
--       },
--       kind_icons = {
--         Compound = "",
--         Recovery = "",
--         TranslationUnit = "",
--         PackExpansion = "",
--         TemplateTypeParm = "",
--         TemplateTemplateParm = "",
--         TemplateParamObject = "",
--       },
--     },
--   },
-- },
-- {
--   "ray-x/lsp_signature.nvim",
--   event = Z.lsp_signature.event,
--   dependencies = Z.lsp_signature.deps,
--   opts = Z.lsp_signature.opts,
-- },
{
  "folke/which-key.nvim",
  event = Z.which_key.event,
  opts = Z.which_key.opts,
  keys = Z.which_key.keys,
},
}
