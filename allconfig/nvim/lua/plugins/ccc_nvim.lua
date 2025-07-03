return {
{
  'uga-rosa/ccc.nvim',
  cmd = { 'CccPick' },
  keys = { '<A-c>', '<CMD>CccPick<CR>', mode = {'n', 'i'} },
  opts = function()
    require'ccc'.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
      mappings = {
        ['<A-l>'] = require'ccc'.mapping.increase10,
        ['<A-h>'] = require'ccc'.mapping.decrease10,
        e = require'ccc'.mapping.complete,
      },
      highlight_mode = "virtual",
    })
  end,

},
}
