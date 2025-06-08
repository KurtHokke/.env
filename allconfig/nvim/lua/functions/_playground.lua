local log = require'functions.logger'.log
local str_in_list = require'functions.string'.str_in_list
log('s', )
local M = {}
function M.test()
  local ts = vim.treesitter
  local pos = vim.api.nvim_win_get_cursor(0)
  local linetext = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)
  -- log(linetext[1], {raw = true})
  -- if true then return end
  local lang = ts.language.get_lang(vim.bo.filetype)
  if lang == nil then
    log("lang not found", {level = vim.log.levels.ERROR, timeout = false})
    return
  end
  local nodes = ts.get_node({
    pos = { pos[1] - 1, math.max(0, pos[2] -1) },
    ignore_injections = false
  })
  if nodes == nil then
    log("nodes not found", {level = vim.log.levels.ERROR, timeout = false})
    return
  end
  -- local nodes = ts.get_captures_at_pos(0, pos[1] - 1, pos[2])
  log(nodes:type(), {raw = true})
  -- local node = ts.get_captures_at_cursor()
  -- log(nodes)
  if str_in_list(nodes, "string") then
    log("found")
  end
  local l = ""
end


return M
