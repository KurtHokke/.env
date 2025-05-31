
return function(msg, level)
  local notify = require'notify'
  if level == nil or level < 1 or level > 6 then
    level = vim.log.levels.INFO
  end
  notify(msg, level)
end

