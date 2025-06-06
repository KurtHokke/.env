local M = {}
local log = require'functions.logger'.log

-- ---@type table<>
-- M.opts = {
--
-- }

---@class get_mod_abspath_OPTS
---@field log? {boolean:true|false}
---@param opts? get_mod_abspath_OPTS
function M.get_mod_abspath(modname, opts)
  local Config = require'lazy.core.config'
  if not Config.spec then
    log('no Config.spec')
    return
  end
  for _, plugin in pairs(Config.spec.plugins) do
    -- str = string.format("%s%s\n", str, plugin.dir)
    local spath = string.format("%s/lua/?/init.lua;%s/lua/?.lua", plugin.dir, plugin.dir)
    local path, _ = package.searchpath(modname, spath)
    if path then
      log(plugin.dir)
      return plugin.dir
    end
  end
  log(string.format("could not resolve path of module:\n%s", modname), {level = vim.log.levels.ERROR, timeout = false})
  return nil
end
return M

