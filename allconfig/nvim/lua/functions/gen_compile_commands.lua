local log = require'functions.logger'.log

---@param args? table
return function(args)
  local buf = vim.api.nvim_get_current_buf()
  if args == nil then
    args = { "--", "/usr/bin/clang", "-O0", "-Wall", "-Wextra", "-Wpedantic", "-g", "-std=gnu11", "-o", }
    local filename = vim.api.nvim_buf_get_name(buf)
    local fileout = string.format("%s.o", filename)
    table.insert(args, fileout)
    table.insert(args, "-c")
    table.insert(args, filename)
  end
  -- log(filename)
  -- log(fileout)
  log(vim.inspect(args))
  local cmd = { "bear", unpack(args) }
  vim.system(cmd, { text = true })
end
