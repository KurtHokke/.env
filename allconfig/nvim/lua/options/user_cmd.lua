
local newcmd = vim.api.nvim_create_user_command

newcmd('PluginExist', function(args)
  require'functions.plugin_utils'.exists(args.fargs[1])
end, { nargs = 1 })
