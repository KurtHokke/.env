local M = {}

--- Documentation
--- @class optstable
--- @field level? number
--- @field raw? boolean
--- @field title? string
--- @field timeout? number|boolean
--- @field render? string
--- @param msg any
--- @param opts? optstable
---  opts:
---  .level (number) 1-6
---  .title (string) Title
---  .timeout (number|boolean) milliseconds to display
---  .render (string) "default"
---                   "minimal"
---                   "simple"
---                   "compact"
---                   "wrapped-compact"
function M.log(msg, opts)
  local notify = require'notify'
  local level = vim.log.levels.INFO
  opts = opts or {}
  if opts.level ~= nil and opts.level >= 1 and opts.level <= 6 then
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
