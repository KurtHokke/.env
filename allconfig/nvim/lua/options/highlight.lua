local M = {}
M.hl_table = {
  ['#dc00ff'] = { '@type.builtin.c', '@lsp.typemod.type.defaultLibrary.c' },
  ['#b907ff'] = { '@keyword.modifier.c' },
  ['#f4c100'] = { '@keyword.import.c' },
  ['#f48800'] = { '@lsp.typemod.parameter.functionScope.c' },
  ['#f46200'] = { '@operator.c' },
  ['#f5a700'] = { '@lsp.typemod.class.defaultLibrary.c' },
  ['#ff0000'] = { '@keyword.conditional.c', '@keyword.repeat.c', '@keyword.return.c', '@operator.deref' },
  ['#cc0000'] = { '@keyword.type.c', '@_parent.c' },
  ['#cc0043'] = { '@keyword.directive.define.c' },
  ['#d58bc8'] = { '@lsp.typemod.macro.globalScope.c' },
  ['#00a0ff'] = { '@lsp.typemod.function.globalScope.c', '@lsp.typemod.function.defaultLibrary.c' },
  ['#22adff'] = { '@lsp.typemod.enum.globalScope.c', '@lsp.type.enumMember.c' },
  ['#2dd0fe'] = { '@number.c' },
  ['#1fe801'] = { '@lsp.type.operator.c' },
  ['#f5d0ff'] = { '@lsp.typemod.variable.functionScope.c' },

}

function M.tokyonight(hl, c)
  hl.BlinkCmpMenuBorder = { fg = "#00cb00" }
  hl.NvimTreeFolderIcon = { fg = "#ffc500", bg = c.none }

end


-- hl(0, 'CursorLineNr', { fg = '#ffa200' })
-- hl(0, 'LineNr', { fg = '#ffffff' })
-- hl(0, '@type.builtin.c', { fg = '#c700e2' })
-- hl(0, '@lsp.typemod.function.globalScope.c', { fg = '#00a2ff' })
-- hl(0, '@lsp.type.enumMember.c', { fg = '#3a74c8' })
-- hl(0, 'cNumber', { fg = '#29d8ff' })
-- hl(0, 'cNumbers', { fg = '#29d8ff' })
-- hl(0, 'cFloat', { fg = '#29d8ff' })
-- hl(0, 'cInclude', { fg = '#fcc603' })
-- hl(0, 'cDefine', { fg = '#d80b48' })
-- hl(0, 'cStructure', { fg = '#c30035' })
-- hl(0, 'cTypedef', { fg = '#bc2829' })
-- hl(0, '@lsp.typemod.macro.globalScope.c', { fg = '#a07df4' })
-- hl(0, '@lsp.typemod.enum.globalScope.c', { fg = '#ba51c8' })
-- hl(0, '@function.call.c', { fg = '#00a2ff' })
-- hl(0, '@type.builtin.c', { fg = '#dd00ff' })
-- hl(0, '@keyword.modifier.c', { fg = '#cf03fc' })
-- hl(0, '@keyword.import.c', { fg = '#fcc603' })
-- hl(0, '@variable.parameter.c', { fg = '#dbb8ff' })
-- hl(0, '@character.printf', { fg = '#ff3700' })
-- hl(0, '@number.c', { fg = '#00f2ff' })
-- hl(0, '@constant.c', { fg = '#00f2ff' })
-- hl(0, '@constant.macro.c', { fg = '#d67dff' })
-- hl(0, '@variable.c', { fg = '#dfc4ff' })
-- hl(0, 'cRepeat', { fg = '#f00019' })
-- hl(0, 'cConditional', { fg = '#ff0019' })
-- hl(0, 'cStatement', { fg = '#ff0019' })

-- local hl = require'functions.hl_setter'.set
-- local config = require'plugins.config.gruvbox'.config
-- M.colortable = {
--   LineNr = {fg = '#ffffff'},
--   CursorLineNr = {fg = '#ffa200'},
--   Normal = {fg = '#eeeeee', bg = '#000000'},
-- }

-- hl(0, 'GruvboxBg2', { fg = '#001100', bg = '#001100' })
-- hl(0, 'GruvboxBg2', { bg = '#001100' })
-- local mytable = { ['#ffffff'] = { 'a', 'b', 'c' }}
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })
-- hl(0, '', { fg = '' })



return M
