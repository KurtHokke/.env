local M = {}

function M.config()
  require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/my_snippets"})
end

return M
