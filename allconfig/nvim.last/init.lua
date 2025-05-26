require("configs.lazy")

require("custom.options")
require("custom.autocmds")

vim.schedule(function()
  require("custom.mappings")
end)

