-- Function to jump to quotes and place cursor before closing quote
local M = {}
function M.jump_to_closing_quote()
  local pos = vim.api.nvim_win_get_cursor(0) -- Current cursor position
  local line = vim.api.nvim_get_current_line() -- Current line text
  local col = pos[2] -- Current column (0-based)
  -- Search for the next single or double quote starting from current column
  local start_idx = line:find("['\"]", col + 1)
  if not start_idx then

    vim.notify("No quotes found after cursor", vim.log.levels.WARN)
return
  end

  -- Get the quote character (' or ")
  local quote_char = line:sub(start_idx, start_idx)
  -- Adjust start_idx to 0-based for cursor positioning
  start_idx = start_idx - 1

  -- Move cursor to the opening quote
  vim.api.nvim_win_set_cursor(0, { pos[1], start_idx })

  -- Find the closing quote
  local end_idx
  local i = start_idx + 2 -- Start searching after the opening quote
  while i <= #line do
    local char = line:sub(i, i)
    if char == quote_char then
      -- Check if the quote is escaped
      local prev_char = i > 1 and line:sub(i - 1, i - 1) or ""
      if prev_char ~= "\\" then
        end_idx = i - 1 -- 0-based index of closing quote
        break
      end
    end
    i = i + 1
  end

  if not end_idx then
    vim.api.nvim_win_set_cursor(0, { pos[1], start_idx + 1 })
    -- vim.notify("No matching closing quote found", vim.log.levels.WARN)
    return
  end

  -- Move cursor one character before the closing quote
  vim.api.nvim_win_set_cursor(0, { pos[1], end_idx })
end

return M
