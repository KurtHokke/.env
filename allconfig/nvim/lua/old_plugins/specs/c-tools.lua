return {
{
  "Civitasv/cmake-tools.nvim",
  enabled = false,
  lazy = true,
  init = function()
    local loaded = false
    local function check()
      local cwd = vim.uv.cwd()
      if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
        require("lazy").load({ plugins = { "cmake-tools.nvim" } })
        loaded = true
      end
    end
    check()
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        if not loaded then
          check()
        end
      end
    })
  end,
  opts = function()
    return require'plugins.config.cmake-tools'.opts
  end,
},
}
