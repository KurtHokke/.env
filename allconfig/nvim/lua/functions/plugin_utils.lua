local M = {}

---@param plugin string
---@param echo? boolean
---@return boolean
function M.is_loaded(plugin, echo)
  local Lazy = require'lazy.core.config'
  local log = require'functions.logger'.log
  echo = echo or false
  if Lazy.plugins[plugin] ~= nil and Lazy.plugins[plugin]._.loaded ~= nil then
    if echo then
      local title = string.format("%s is_loaded?", plugin)
      log("true", { render = 'compact', title = title })
    end
    return true
  end
  if echo then
    local title = string.format("%s is_loaded?", plugin)
    log("false", { render = 'compact', title = title })
  end
  return false
end

---@param plugin string
---@param echo? boolean
---@return boolean
function M.exists(plugin, echo)
  local Lazy = require'lazy.core.config'
  local log = require'functions.logger'.log
  echo = echo or false
  if Lazy.plugins[plugin] ~= nil then
    if echo then
      local title = string.format("%s exists?", plugin)
      log("true", { render = 'compact', title = title })
    end
    return true
  end
  if echo then
    local title = string.format("%s exists?", plugin)
    log("false", { render = 'compact', title = title })
  end
  return false
end

return M
