require'options.user_cmd'


vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'vim', 'c', 'cpp', 'CMakeLists.txt', 'cmake', 'sh', 'bash', 'css', 'desktop' },
  callback = function() vim.treesitter.start() end,
})

local is_loaded = require'functions.plugin_utils'.is_loaded
local plugin_exists = require'functions.plugin_utils'.exists

if is_loaded('tokyonight.nvim') then
  vim.cmd[[colorscheme tokyonight]]
end

if plugin_exists('ccc.nvim') then
  require'plugins.config.ccc'.mapping()
end

require'functions.hl_setter'.syntax_hl(require'options.highlight'.hl_table)
