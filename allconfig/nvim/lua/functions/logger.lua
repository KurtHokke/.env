---@class Logger
local M = {}


---@alias LogLevels
---|` vim.log.levels.INFO`
---|` vim.log.levels.WARN`
---|` vim.log.levels.ERROR`
---|` vim.log.levels.DEBUG`
---|` vim.log.levels.TRACE`
---|` vim.log.levels.OFF`
---@alias RenderType
---|` 'default'`
---|` 'minimal'`
---|` 'simple'`
---|` 'compact'`
---|` 'wrapped-compact'`
---|` function()  end`

--- @class optstable
--- @field level? LogLevels|number 
--- @field raw? boolean
--- |` true`
--- |` false`
--- @field title? string
--- @field icon? string
--- @field timeout? number|boolean
--- |` false`
--- @field animate? boolean
--- |` false`
--- @field hide_from_history? boolean
--- @field render? RenderType|number|function
--- @field replace? number|notify.Record
--- @field on_open? function
--- |` function()  end`
--- @field on_close? function
--- |` function()  end`
---@param msg string
---@param opts? optstable
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
