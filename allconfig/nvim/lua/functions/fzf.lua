local M = {}
local log = require'functions.logger'.log

function M.live_grep_nvimtreedir()
  local nt_api = require'nvim-tree.api'
  local node = nt_api.tree.get_node_under_cursor()

  if node.absolute_path ~= nil then
    -- log(node.absolute_path, {raw = true})
    require'fzf-lua'.live_grep({ cwd = node.absolute_path })
  end
end

return M
