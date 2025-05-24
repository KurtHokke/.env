
local M = {}

function M.f(opts)
  opts = opts or {}
  if type(opts) ~= "table" then
    return
  end
  local api = require("nvim-tree.api")
  if opts.toggle ~= nil and opts.toggle then
    if type(opts.toggle) ~= "boolean" then
      return
    end
    local buf = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(buf)
    if filepath:match("NvimTree_") then
      api.tree.close()
    else
      api.tree.focus()
    end
    return
  end
  if opts.resize ~= nil and opts.resize then
    if type(opts.resize) == "table" then
      local resizeopts = {}
      if opts.resize.relative ~= nil and type(opts.resize.relative) == "number" and opts.resize.absolute == nil then
        resizeopts.relative = opts.resize.relative
      elseif opts.resize.absolute ~= nil and type(opts.resize.absolute) == "number" then
        resizeopts.absolute = opts.resize.absolute
      else
        return
      end
      api.tree.resize(resizeopts)
    end
  end
end

return M
