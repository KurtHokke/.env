return {
{
  'akinsho/bufferline.nvim',
  event = "BufFilePost",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      -- mode = "tabs",
      separator_style = "slant",
      custom_filter = function(buf_number) -- buf_number, buf_numbers
        if vim.fn.bufname(buf_number) ~= "" then
            return true
        end
      end
    },
  },
},
}
