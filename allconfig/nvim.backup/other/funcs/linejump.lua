
local M = {}

function M.linejump(n)
  local pos = vim.api.nvim_win_get_cursor(0)
  local currentLine = pos[1]
  local column = pos[2]
  local destLine = currentLine + n
  local maxLine = vim.api.nvim_buf_line_count(0)
  if destLine < 1 then
    destLine = 1
  elseif destLine > maxLine then
    destLine = maxLine
  end
  local line_content = vim.api.nvim_buf_get_lines(0, destLine - 1, destLine, false)[1] or ""
  if column > #line_content then
    column = math.max(0, #line_content - 1)
  end
  vim.api.nvim_win_set_cursor(0, { destLine, column })
end

return M
