local M = {}

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

M.opts = {
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end,
  open_fold_hl_timeout = 400,
  close_fold_kinds_for_ft = {default = {}},
  fold_virt_text_handler = nil,
  enable_get_fold_virt_text = false,
  preview = {
    win_config = {
      border = 'rounded',
      winblend = 12,
      winhighlight = 'Normal:Normal',
      maxheight = 20
    },
    mappings = {
      scrollB = '',
      scrollF = '',
      scrollU = '',
      scrollD = '',
      scrollE = '<C-E>',
      scrollY = '<C-Y>',
      jumpTop = '',
      jumpBot = '',
      close = 'q',
      switch = '<Tab>',
      trace = '<CR>'
    }
  }
}


return M
