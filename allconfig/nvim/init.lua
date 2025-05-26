require("lazy-nvim")

vim.lsp.config["luals"] = {
  require("pconfig.luals_config")
}
vim.lsp.enable("luals")

