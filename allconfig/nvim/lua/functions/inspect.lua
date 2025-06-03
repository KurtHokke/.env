local M = {}
local log = require'functions.logger'.log
function M.inspect()
  local pos = vim.api.nvim_win_get_cursor(0)
  local ins = vim.inspect_pos(0, pos[1] - 1, pos[2])
  local msg = ""
  if #ins.treesitter > 0 then
    msg = string.format("%streesitter:\n", msg)
    for i=1,#ins.treesitter do
      -- log(vim.inspect(ins.treesitter[i]))
      local hl_group = vim.inspect(ins.treesitter[i]["hl_group"])
      msg = string.format("%s %d:%s\n", msg, i, hl_group)
    end
  end
  if #ins.syntax > 0 then
    msg = string.format("%ssyntax:\n", msg)
    for i=1,#ins.syntax do
      local hl_group = vim.inspect(ins.syntax[i]["hl_group"])
      msg = string.format("%s %d:%s\n", msg, i, hl_group)
    end
  end
  if #ins.semantic_tokens > 0 then
    msg = string.format("%ssemantic_tokens:\n", msg)
    for i=1,#ins.semantic_tokens do
      local priority = vim.inspect(ins.semantic_tokens[i]["opts"]["priority"])
      local hl_group = vim.inspect(ins.semantic_tokens[i]["opts"]["hl_group"])
      msg = string.format("%s %d:^%d,%s\n", msg, i, priority, hl_group)
    end
  end
  log(msg, { title = "hokke", render = "compact" })
end
return M
