_G.pConfig = {}
local log = require'functions.logger'.log

return function()
  local ok, lfs = pcall(require, 'lfs')
  if not ok then
    log("can't find LuaFileSystem(lfs.so)", {render = "simple"})
    return false
  end
  local files_list = {}
  local files = ""
  for fname in lfs.dir(vim.fn.stdpath('config') .. '/lua/plugins/config') do
    -- log(vim.inspect(fname))
    if fname ~= "." and fname ~= ".." then
      local name = string.format("plugins.config.%s", fname:gsub("%.lua$", ""))
      table.insert(files_list, name)
      files = string.format("%s%s\n", files, fname:gsub("%.lua$", ""))
    end
  end
  -- for i = 1, #files_list do
  --   local cfg = require
  -- end
  log(files)
  log(vim.inspect(files_list))
end

