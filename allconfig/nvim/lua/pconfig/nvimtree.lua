local M = {}
M.config = {
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local function map_opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- Load default mappings
    api.config.mappings.default_on_attach(bufnr)
    -- Override 'e' to collapse directory
    vim.keymap.set("n", "e", api.node.open.edit, map_opts("Open File Or Folder"))
  end,
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 22,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
}
function M.mytree(opts)
  opts = opts or {}
  if type(opts) ~= "table" then
    return
  end
  local api = require("nvim-tree.api")
  if opts.toggle ~= nil and opts.toggle then
    if type(opts.toggle) ~= "boolean" then
      return
    end
    local buf = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(buf)
    if filepath:match("NvimTree_") then
      api.tree.close()
    else
      api.tree.focus()
    end
    return
  end
  if opts.resize ~= nil and opts.resize then
    if type(opts.resize) == "table" then
      local resizeopts = {}
      if opts.resize.relative ~= nil and type(opts.resize.relative) == "number" and opts.resize.absolute == nil then
        resizeopts.relative = opts.resize.relative
      elseif opts.resize.absolute ~= nil and type(opts.resize.absolute) == "number" then
        resizeopts.absolute = opts.resize.absolute
      else
        return
      end
      api.tree.resize(resizeopts)
    end
  end
end

return M
