
local newcmd = vim.api.nvim_create_user_command
local log = require'functions.logger'.log

-- newcmd('LuaRocks', function()
--   local rocks = require'plugins.config.luarocks'.rocks
--   require'luarocks-nvim'.setup({
--     rocks = rocks,
--   })
-- end, {})

newcmd('TestLIB', function(args)
  local test = require'fnames'
  local paths = test.fnames(args.fargs[1])
  log(vim.inspect(paths))
end, { nargs = 1 })

newcmd('PluginExist', function(args)
  require'functions.plugin_utils'.exists(args.fargs[1], true)
end, { nargs = 1 })

newcmd('PluginLoaded', function(args)
  require'functions.plugin_utils'.is_loaded(args.fargs[1], true)
end, { nargs = 1 })

local function GoTo_completion(arg_lead, cmd_line, cursor_pos)
  -- Get files in the current directory
  local alias = { "-nvim" }
  local paths = vim.fn.glob(arg_lead .. "*/", false, true)
  local cmp = vim.tbl_extend("keep", alias, paths)
  return cmp
end

newcmd('GoTo', function(args)
  if args.fargs[1] ~= nil then
    local path = args.fargs[1]
    local alias = string.lower(path)
    if alias == '-nvim' then
      vim.api.nvim_set_current_dir(vim.fn.stdpath('config'))
    elseif vim.fn.isdirectory(path) == 1 then
      vim.api.nvim_set_current_dir(path)
    end
  else
    if vim.fn.getcwd() == vim.g.starting_directory then
      vim.api.nvim_set_current_dir(vim.fn.stdpath('config'))
    else
      vim.api.nvim_set_current_dir(vim.g.starting_directory)
    end
    -- log(vim.g.starting_directory)
  end
end, { nargs = '?', complete = GoTo_completion })


newcmd('ActiveLinters', function()
  local running = require'lint'.get_running()
  log(vim.inspect(running))
end, {})
