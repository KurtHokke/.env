local M = {}

M.ensure_installed = {
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
    "bash",
    "c",
    "cpp",
    "css",
    "cmake",
    "desktop",
    "regex",
    "rust",
    "jsonc",
    "query",
}
function M.need_update()
  local is_installed = require'nvim-treesitter'.get_installed()
  if #is_installed == 0 then
    return true
  end
  for _, v in ipairs(M.ensure_installed) do
    local found_installed = false
    for _, vv in ipairs(is_installed) do
      if v == vv then
        found_installed = true
        break
      end
    end
    if found_installed == false then
      return true
    end
  end
  return false
end

function M.config()
  if M.need_update() then
    require'nvim-treesitter'.install(M.ensure_installed)
  end
end

return M
