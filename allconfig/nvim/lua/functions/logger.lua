local M = {}

--- Documentation
--- @class table
--- @field level? number
--- @field title? string
--- @field timeout? number|boolean
--- @field render? string
--- @param msg string
--- @param opts? table
---  opts:
---  .level (number) 1-6
---  .title (string) Title
---  .timeout (number|boolean) seconds to display
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
  notify(msg, level, opts)
end

return M
