
local lint = require'lint'

vim.filetype.add({
  filename = {
    ["CMakeLists.txt"] = "cmake",
  },
  pattern = {
    [".*%.cmake$"] = "cmake",
  },
})

lint.linters_by_ft = {
  cmake = { "cmake-lint" },
}
-- Create autocommand to trigger linting
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = function()
    lint.try_lint() -- Run linters for current filetype
  end,
})

-- Optional: Keymap to manually trigger linting
vim.keymap.set("n", "<leader>l", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })

