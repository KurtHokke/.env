local M = {}
local log = require'functions.logger'.log

function M.dump_lua(data, filepath)
  if data == nil or filepath == nil then
    log('missing args')
    return false
  end
  local serialized = vim.inspect(data)
  local file, err = io.open(filepath, "w")

  if not file then
    print("Error opening file: " .. (err or "unknown error"))
    return false
  end

  local success, write_err = pcall(file.write, file, serialized)
  file:close()

  if not success then
    print("Error writing to file: " .. (write_err or "unknown error"))
    return false
  end
  return true
end

return M
