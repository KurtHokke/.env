local M = {}
local log = require'notify'
local info = vim.log.levels.INFO
function M.jump()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'i', false)
  local pos = vim.api.nvim_win_get_cursor(0)
  local linenr = pos[1] - 1
  local col = pos[2]
  local searchcol = col
  local foundEnd = false
  repeat
    local nextline = vim.api.nvim_buf_get_lines(0, linenr, linenr + 1, false)
    if nextline[1] == nil then
      return
    end
    local endpos = nextline[1]:find("[}%]%)%'%\"]", searchcol + 1)
    searchcol = -1
    if endpos ~= nil then
      vim.api.nvim_win_set_cursor(0, { linenr + 1, endpos })
      vim.api.nvim_feedkeys('a', 'n', false)
      local char = vim.api.nvim_buf_get_text(0, linenr, endpos -1, linenr, endpos, {})[1]
      -- if char == '}' then
      --   log('}', info)
      -- elseif char == ']' then
      --   log(']', info)
      -- elseif char == ')' then
      --   log(')', info)
      -- elseif char == "'" then
      --   log("'", info)
      -- elseif char == '"' then
      --   log('"', info)
      -- end
      foundEnd = true
    end
    linenr = linenr + 1
  until foundEnd == true
  if not foundEnd then
    log("didnt find }", vim.log.levels.INFO)
  end
end
return M
