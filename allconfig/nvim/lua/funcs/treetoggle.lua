
local M = {}

function M.f()
  local ntapi = require("nvim-tree.api")
  local buf = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(buf)
  if filepath:match("NvimTree_") then
    ntapi.tree.close()
  else
    ntapi.tree.focus()
  end
end

return M
