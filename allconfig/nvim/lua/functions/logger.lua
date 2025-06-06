local M = {}

-- ---@enum LogLevels
-- M._loglevels = {
--   off = vim.log.levels.OFF,
--   info = vim.log.levels.INFO,
--   warn = vim.log.levels.WARN,
--   error = vim.log.levels.ERROR,
--   debug = vim.log.levels.DEBUG,
--   trace = vim.log.levels.TRACE,
-- }
---@alias LogLevels
---| number
---|` vim.log.levels.OFF`
---|` vim.log.levels.INFO`
---|` vim.log.levels.WARN`
---|` vim.log.levels.ERROR`
---|` vim.log.levels.DEBUG`
---|` vim.log.levels.TRACE`
---@alias TrueOrFalse
---| boolean
---|` false`
---|` true`
---@alias RenderType
---|` 'default'`
---|` 'minimal'`
---|` 'simple'`
---|` 'compact'`
---|` 'wrapped-compact'`

--- Documentation
--- @class optstable
--- @field level? LogLevels
--- @field raw? TrueOrFalse
--- @field title? string
--- @field timeout? number|TrueOrFalse
--- @field render? RenderType
--- @param msg any
--- @param opts? optstable
function M.log(msg, opts)
  local notify = require'notify'
  local level = vim.log.levels.INFO
  opts = opts or {}
  if opts.level ~= nil and opts.level >= 0 and opts.level <= 5 then
    level = opts.level
    opts.level = nil
  end
  if opts.timeout == nil or type(opts.timeout) ~= "number" or type(opts.timeout) ~= "boolean" then
    opts.timeout = 8000
  end
  if opts.raw ~= nil and type(opts.raw) == "boolean" and opts.raw == true then
    notify(vim.inspect(msg), level, opts)
  else
    notify(msg, level, opts)
  end
end

return M
