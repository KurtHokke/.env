local M = {}
local log = require'functions.logger'.log

---@param hl_table table
function M.syntax_hl(hl_table)
  -- local hl_table = {
  --   ['#ffffff'] = { 'dede', 'ageg' }
  -- }
  hl_table = hl_table or {}
  if type(hl_table) ~= "table" then
    log("hl_table ~= table", { timeout = false })
    return
  end
  for k, v in pairs(hl_table) do
    if type(v) == "table" then
      -- local str = string.format("%s:\n", k)
      for i = 1, #v do
        -- log(string.format("vim.api.nvim_set_hl(0, '%s', { fg = '%s' })", v[i], k))
        -- str = string.format("%s%s\n", str, v[i])
        vim.api.nvim_set_hl(0, v[i], { fg = k })
      end
      -- log(str)
    end
  end
end

-- function M.setGruvbox(mytable)
--   -- local mytable = {
--   --   ['#ffffff'] = { fg = { 'LineNr', 'CursorLineNr' } },
--   --   ['#cd0000'] = { fg = { 'GruvboxBg2' }, bg = { 'GruvboxBg4' } },
--   -- }
--   local output = {}
--
--   for color, value in pairs(mytable) do
--     if type(value) == "table" then
--       for fgbg, tokens in pairs(value) do
--         if type(tokens) == "table" then
--           for _, token in ipairs(tokens) do
--             output[token] = output[token] or {}
--             output[token][fgbg] = color
--           end
--         end
--       end
--     end
--   end
--   if type(output) ~= "table" then
--     return
--   end
--   for key, value in pairs(output) do
--     local str = string.format("%s = { %s = '%s' }", key, next(value), value[next(value)])
--     log(str, info)
--   end
--   return output
-- end
--
-- function M.sethl(mytable)
--   -- local mytable = {
--   --   ['#ffffff'] = { fg = { 'LineNr', 'CursorLineNr' } },
--   --   ['#cd0000'] = { fg = { 'GruvboxBg2' }, bg = { 'GruvboxBg4' } },
--   -- }
--
--   for color, value in pairs(mytable) do
--     local str = string.format("%s", color)
--     log(str, info)
--
--     if type(value) == "table" then
--       log("is table", info)
--       for fgbg, tokens in pairs(value) do
--         log(fgbg, info)
--         if type(tokens) == "table" then
--           log("is also table", info)
--           for _, token in ipairs(tokens) do
--             local opts = {}
--             opts[fgbg] = color
--             hl(0, token, opts)
--             local out = string.format("hl(0, '%s', { %s = '%s' })", token, fgbg, color)
--             log(out, info)
--           end
--         end
--       end
--     end
--   end
-- end
--
-- function M.set(mytable, opts)
--   if opts == nil then
--     log("opts nil", info)
--     M.sethl(mytable)
--     return
--   elseif type(opts) == "table" and opts['gruvbox'] == true then
--     log("not nil")
--     local ret = M.setGruvbox(mytable)
--     return ret
--   end
--   log("nothing", info)
-- end

return M
