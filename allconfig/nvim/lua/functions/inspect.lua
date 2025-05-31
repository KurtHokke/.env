local M = {}
local function log(msg)
  require'notify'(tostring(msg), vim.log.levels.INFO)
end
function M.inspect()
  local pos = vim.api.nvim_win_get_cursor(0)
  local ins = vim.inspect_pos(0, pos[1] - 1, pos[2])
  local msg = ""
  if #ins.treesitter > 0 then
    msg = string.format("treesitter:\n")
    for i=1,#ins.treesitter do
      local hl_group = vim.inspect(ins.treesitter[i]["hl_group"])
      msg = string.format("%s %d:%s", msg, i, hl_group)
      if i < #ins.treesitter then
        msg = string.format("%s\n", msg)
      end
      -- msg = string.format("%s  hl_group_link[%d]: %s\n", msg, i, vim.inspect(ins.syntax[i]["hl_group_link"]))
      -- log(msg)
    end
  end
  if #ins.syntax > 0 then
    msg = string.format("syntax:\n")
    for i=1,#ins.syntax do
      local hl_group = vim.inspect(ins.syntax[i]["hl_group"])
      msg = string.format("%s %d:%s", msg, i, hl_group)
      if i < #ins.syntax then
        msg = string.format("%s\n", msg)
      end
      -- msg = string.format("%s  hl_group_link[%d]: %s\n", msg, i, vim.inspect(ins.syntax[i]["hl_group_link"]))
      -- log(msg)
    end
  end
  if #ins.semantic_tokens > 0 then
    msg = string.format("semantic_tokens:\n")
    for i=1,#ins.semantic_tokens do
      local priority = vim.inspect(ins.semantic_tokens[i]["opts"]["priority"])
      local hl_group = vim.inspect(ins.semantic_tokens[i]["opts"]["hl_group"])
      msg = string.format("%s %d:^%d,%s", msg, i, priority, hl_group)
      if i < #ins.semantic_tokens then
        msg = string.format("%s\n", msg)
      end
      -- msg = string.format("%s  hl_group_link[%d]: %s\n", msg, i, vim.inspect(ins.semantic_tokens[i]["opts"]["hl_group_link"]))
      -- log(msg)
    end
  end
  -- log(vim.inspect(ins.semantic_tokens[1]))
  log(msg)
  -- log(vim.inspect(ins.semantic_tokens))
  -- log(vim.inspect(#ins.syntax))
  -- log(vim.inspect(ins.syntax[1]))
  -- log(ins.treesitter)
  -- log(ins['syntax'][1])
end
return M
