local M = {}

---@param plugin string
---@return boolean
function M.is_loaded(plugin)
  local Lazy = require'lazy.core.config'
  -- local log = require'functions.logger'
  if Lazy.plugins[plugin] ~= nil and Lazy.plugins[plugin]._.loaded ~= nil then
    -- log("true")
    return true
  end
  -- log("false")
  return false
end

---@param plugin string
---@return boolean
function M.exists(plugin)
  local Lazy = require'lazy.core.config'
  -- local log = require'functions.logger'
  if Lazy.plugins[plugin] ~= nil then
    print("true")
    return true
  end
  print("false")
  return false
end

return M
