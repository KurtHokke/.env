require "nvchad.options"

-- add yours here!

local o = vim.o
local hl = vim.api.nvim_set_hl

o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.cursorlineopt ='both' -- to enable cursorline!

hl(0, '@function.call.c', { fg = '#00a2ff' })
hl(0, '@function.c', { fg = '#00a2ff' })
hl(0, '@type.builtin.c', { fg = '#e100ff' })
hl(0, '@keyword.modifier.c', { fg = '#b700ff' })
hl(0, '@keyword.import.c', { fg = '#e2c000' })
hl(0, '@type.c', { fg = '#e29700' })
hl(0, '@constant.builtin.c', { fg = '#ef97ff' })
hl(0, '@variable.c', { fg = '#c6c8ff' })
hl(0, '@number.c', { fg = '#00dac7' })
hl(0, '@constant.c', { fg = '#d2a8ff' })
hl(0, '@property.c', { fg = '#f1dfff' })
hl(0, '@operator.c', { fg = '#c45522' })
hl(0, '@keyword.conditional.c', { fg = '#ff2a0e' })
hl(0, '@keyword.repeat.c', { fg = '#ff2a0e' })
hl(0, '@character.printf', { fg = '#ff2a0e' })
hl(0, '@string.escape.c', { fg = '#00e5ff' })
hl(0, '@punctuation.bracket.c', { fg = '#ffb23e' })
hl(0, '@punctuation.delimiter.c', { fg = '#ffaaaa' })


-- hl(0, 'customA', { fg = 'cyan' })

-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    -- pattern = {"*.c", "*.h"},
    -- callback = function ()
        -- local query = [[
            -- ((identifier) @includeImport
            -- (#match? @includeImport "#include <.*\.h>")
            -- (#offset! @includeImport 0 9 0 0))
        -- ]]
        -- vim.treesitter.query.set("c", "my_highlights", query)
        -- vim.api.nvim_buf_set_option(0, 'syntax', 'on')
    -- end,
-- })

-- hl(0, '@includeImport', { link = 'customA'})
