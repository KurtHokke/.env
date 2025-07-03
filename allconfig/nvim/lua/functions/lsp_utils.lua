local M = {}
function M.append_lua_ls_library(path)
  -- Normalize path (expand ~ and resolve relative paths)
  path = vim.fn.expand(path)
  if not vim.fn.isdirectory(path) then
    print("Error: " .. path .. " is not a valid directory")
    return
  end

  -- Find all active lua_ls clients
  local clients = vim.lsp.get_clients({ name = "lua_ls" })
  if #clients == 0 then
    print("No active lua_ls client found")
    return
  end

  for _, client in ipairs(clients) do
    -- Get or initialize settings
    local settings = client.config.settings or {}
    settings.Lua = settings.Lua or {}
    settings.Lua.workspace = settings.Lua.workspace or {}
    settings.Lua.workspace.library = settings.Lua.workspace.library or {}

    -- Check if path is already in library
    if not vim.tbl_contains(settings.Lua.workspace.library, path) then
      table.insert(settings.Lua.workspace.library, path)
      -- Update client config
      client.config.settings = settings
      -- Notify server of configuration change
      client.notify("workspace/didChangeConfiguration", {
        settings = settings
      })
      print("Appended " .. path .. " to lua_ls workspace.library")
    else
      print(path .. " is already in lua_ls workspace.library")
    end
  end
end


return M
-- Example usage
-- append_lua_ls_library("~/.local/share/nvim/lazy/ccc/lua")
