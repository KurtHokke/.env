local M = {}

M.log = require'functions.logger'.log

M.aliases = {
  "--nvim",
  "--data",
  "--zsh",
}

function M.GoTo_completion(arg_lead, cmd_line, cursor_pos)
  -- Get files in the current directory
  local paths = vim.fn.glob(arg_lead .. "*/", false, true)
  local cmp = vim.tbl_extend("keep", M.aliases, paths)
  return cmp
end

---@param path string?
function M.GoTo(path)
  if path ~= nil then
    local alias = string.lower(path)
    if alias == M.aliases[1] then
      vim.api.nvim_set_current_dir(vim.fn.stdpath('config'))
    elseif alias == M.aliases[2] then
      vim.api.nvim_set_current_dir(vim.fn.stdpath('data'))
    elseif alias == M.aliases[3] then
      path = os.getenv("ZDOTDIR")
      if path == nil then
        M.log("ZDOTDIR was nil")
        return
      end
      vim.api.nvim_set_current_dir(path)
    elseif vim.fn.isdirectory(path) == 1 then
      vim.api.nvim_set_current_dir(path)
    end
  else
    if vim.fn.getcwd() == vim.g.starting_directory then
      vim.api.nvim_set_current_dir(vim.fn.stdpath('config'))
    else
      vim.api.nvim_set_current_dir(vim.g.starting_directory)
    end
    -- log(vim.g.starting_directory)
  end
end

return M
