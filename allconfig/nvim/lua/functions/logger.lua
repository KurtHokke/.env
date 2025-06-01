---@param msg string
---@param opts? table
return function(msg, opts)
  local notify = require'notify'
  local level = vim.log.levels.INFO
  opts = opts or {}
  if opts.level ~= nil and opts.level >= 1 and opts.level <= 6 then
    level = opts.level
    opts.level = nil
  end
  opts.opts = opts.opts or {}
  notify(msg, level, opts)
end

