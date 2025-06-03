local M = {}

---@param path string
---@param max_components? number Defaulting to 3 if nil
function M.shorten_path(path, max_components)
  max_components = max_components or 3 -- Default to keeping last 3 components
  local components = {}
  -- Split path by '/'
  for component in path:gmatch("[^/]+") do
    table.insert(components, component)
  end
  -- If the number of components is less than or equal to max_components, return the original path
  if #components <= max_components then
    return path
  end
  -- Keep the last max_components and prepend '...'
  local short_components = {}
  for i = #components - max_components + 1, #components do
    table.insert(short_components, components[i])
  end
  return "..." .. "/" .. table.concat(short_components, "/")
end

return M
