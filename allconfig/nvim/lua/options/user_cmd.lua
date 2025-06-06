
local newcmd = vim.api.nvim_create_user_command
local log = require'functions.logger'.log

-- newcmd('LuaRocks', function()
--   local rocks = require'plugins.config.luarocks'.rocks
--   require'luarocks-nvim'.setup({
--     rocks = rocks,
--   })
-- end, {})
newcmd('StrInList', function()
  package.loaded['functions.string'] = nil
  local get = require'functions.string'.str_in_list
  get()
end, {})

newcmd('GetPath', function(args)
  -- package.loaded["functions.module_utils"] = nil
  local get = require'functions.module_utils'.get_mod_abspath
  get(args.fargs[1])
end, {nargs = 1})

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

-- local function GoTo_completion(arg_lead, cmd_line, cursor_pos)
--   -- Get files in the current directory
--   local alias = { "-nvim" }
--   local paths = vim.fn.glob(arg_lead .. "*/", false, true)
--   local cmp = vim.tbl_extend("keep", alias, paths)
--   return cmp
-- end
local GoTo = require'functions.GoTo'
newcmd('GoTo', function(args)
  local path = args.fargs[1] or nil
  GoTo.GoTo(path)
end, { nargs = '?', complete = GoTo.GoTo_completion })


newcmd('ActiveLinters', function()
  local running = require'lint'.get_running()
  log(vim.inspect(running))
end, {})
