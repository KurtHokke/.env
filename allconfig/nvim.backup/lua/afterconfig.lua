require("options.highlight")

local ccc_enable = true
local theme = 'tokyonight'

if theme == 'tokyonight' then
  vim.cmd[[colorscheme tokyonight]]
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'vim', 'c', 'cpp', 'CMakeLists.txt', 'sh', 'bash', 'css', 'desktop' },
  callback = function() vim.treesitter.start() end,
})

if ccc_enable then
  require'pconfig.ccc'.mapping()
end
