local M = {}

function M.lint_progress()
  local linters = require("lint").get_running()
  if #linters == 0 then
      return "󰦕"
  end
  return "󱉶 " .. table.concat(linters, ", ")
end

--require'lualine'
---@module "lualine"
M.config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', 'lsp_status', M.lint_progress },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
  -- options = {
  --   theme = 'auto', -- lualine theme
  --   component_separators = { left = '', right = '' },
  --   section_separators = { left = '', right = '' },
  --   disabled_filetypes = {     -- Filetypes to disable lualine for.
  --       statusline = {},       -- only ignores the ft for statusline.
  --       winbar = {},           -- only ignores the ft for winbar.
  --   },
  --
  --   ignore_focus = {},         -- If current filetype is in this list it'll
  --                              -- always be drawn as inactive statusline
  --                              -- and the last window will be drawn as active statusline.
  --                              -- for example if you don't want statusline of
  --                              -- your file tree / sidebar window to have active
  --                              -- statusline you can add their filetypes here.
  --                              --
  --                              -- Can also be set to a function that takes the
  --                              -- currently focused window as its only argument
  --                              -- and returns a boolean representing whether the
  --                              -- window's statusline should be drawn as inactive.
  --
  --   always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
  --                                -- can't take over the entire statusline even
  --                                -- if neither of 'x', 'y' or 'z' are present.
  --
  --   always_show_tabline = true, -- When set to true, if you have configured lualine for displaying tabline
  --                           -- then tabline will always show. If set to false, then tabline will be displayed
  --                           -- only when there are more than 1 tab. (see :h showtabline)
  --
  --   globalstatus = false,        -- enable global statusline (have a single statusline
  --                                -- at bottom of neovim instead of one for  every window).
  --                                -- This feature is only available in neovim 0.7 and higher.
  --
  --   refresh = {                  -- sets how often lualine should refresh it's contents (in ms)
  --     statusline = 100,         -- The refresh option sets minimum time that lualine tries
  --     tabline = 100,            -- to maintain between refresh. It's not guarantied if situation
  --     winbar = 100              -- arises that lualine needs to refresh itself before this time
  --                                -- it'll do it.
  --
  --                                -- Also you can force lualine's refresh by calling refresh function
  --                                -- like require('lualine').refresh()
  --   }
  -- },
  -- sections = {
  --   lualine_a = {
  --     {
  --       'mode',
  --       icons_enabled = true, -- Enables the display of icons alongside the component.
  --       -- Defines the icon to be displayed in front of the component.
  --       -- Can be string|table
  --       -- As table it must contain the icon as first entry and can use
  --       -- color option to custom color the icon. Example:
  --       -- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}
  --
  --       -- icon position can also be set to the right side from table. Example:
  --       -- {'branch', icon = {'', align='right', color={fg='green'}}}
  --       icon = nil,
  --
  --       separator = nil,      -- Determines what separator to use for the component.
  --                             -- Note:
  --                             --  When a string is provided it's treated as component_separator.
  --                             --  When a table is provided it's treated as section_separator.
  --                             --  Passing an empty string disables the separator.
  --                             --
  --                             -- These options can be used to set colored separators
  --                             -- around a component.
  --                             --
  --                             -- The options need to be set as such:
  --                             --   separator = { left = '', right = ''}
  --                             --
  --                             -- Where left will be placed on left side of component,
  --                             -- and right will be placed on its right.
  --                             --
  --
  --       cond = nil,           -- Condition function, the component is loaded when the function returns `true`.
  --
  --       draw_empty = false,   -- Whether to draw component even if it's empty.
  --                             -- Might be useful if you want just the separator.
  --
  --       -- Defines a custom color for the component:
  --       --
  --       -- 'highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' } | function
  --       -- Note:
  --       --  '|' is synonymous with 'or', meaning a different acceptable format for that placeholder.
  --       -- color function has to return one of other color types ('highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' })
  --       -- color functions can be used to have different colors based on state as shown below.
  --       --
  --       -- Examples:
  --       --   color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
  --       --   color = { fg = 204 }   -- When fg/bg are omitted, they default to the your theme's fg/bg.
  --       --   color = 'WarningMsg'   -- Highlight groups can also be used.
  --       --   color = function(section)
  --       --      return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
  --       --   end,
  --       color = nil, -- The default is your theme's color for that section and mode.
  --
  --       -- Specify what type a component is, if omitted, lualine will guess it for you.
  --       --
  --       -- Available types are:
  --       --   [format: type_name(example)], mod(branch/filename),
  --       --   stl(%f/%m), var(g:coc_status/bo:modifiable),
  --       --   lua_expr(lua expressions), vim_fun(viml function name)
  --       --
  --       -- Note:
  --       -- lua_expr is short for lua-expression and vim_fun is short for vim-function.
  --       type = nil,
  --
  --       padding = 1, -- Adds padding to the left and right of components.
  --                    -- Padding can be specified to left or right independently, e.g.:
  --                    --   padding = { left = left_padding, right = right_padding }
  --
  --       fmt = nil,   -- Format function, formats the component's output.
  --                    -- This function receives two arguments:
  --                    -- - string that is going to be displayed and
  --                    --   that can be changed, enhanced and etc.
  --                    -- - context object with information you might
  --                    --   need. E.g. tabnr if used with tabs.
  --       on_click = nil, -- takes a function that is called when component is clicked with mouse.
  --                    -- the function receives several arguments
  --                    -- - number of clicks in case of multiple clicks
  --                    -- - mouse button used (l(left)/r(right)/m(middle)/...)
  --                    -- - modifiers pressed (s(shift)/c(ctrl)/a(alt)/m(meta)...)
  --     }
  --   }
  -- },
}

return M
