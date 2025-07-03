local ls = require("luasnip") --{{{
-- some shorthands...
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")
-- -- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- -- placeholder 2,... --}}}

ls.add_snippets("lua", {
  s("func", fmt([[
  function {}()
    {}
  end
  ]], {i(1), i(2)})),
  s("local", { t("local ") }),
  s("return", { t("return ") }),
  s({trig = "return {", priority = 900}, fmt([[
  return {{{}
  }}
  ]], {i(1)})),
  s('requ', { t("require'"), i(1), t("'"), i(0) })
}, {default_priority = 1000})



-- ls.add_snippets("lua", { ---{{{
--   s("require", {
--     t("require"),
--     t("'"),
--     i(1),
--     t("'"),
--     i(0),
--   }),
--   s("local", { t("local ") }),
--   s("return", { t("return ") }),
--   s('func', {
--     t({'function '}),
--     i(1, ''),
--     t({'()', '\t'}),
--     i(2),
--     t({'', 'end'}),
--     i(0),
--   }),
-- })
-- ls.add_snippets("all", {
--   -- trigger is `fn`, second argument to snippet-constructor are the nodes to insert into the buffer on expansion.
--   s("fn", {
--     -- Simple static text.
--     t("//Parameters: "),
--     -- function, first parameter is the function, second the Placeholders
--     -- whose text it gets as input.
--     f(copy, 2),
--     t({ "", "function " }),
--     -- Placeholder/Insert.
--     i(1),
--     t("("),
--     -- Placeholder with initial text.
--     i(2, "int foo"),
--     -- Linebreak
--     t({ ") {", "\t" }),
--     -- Last Placeholder, exit Point of the snippet.
--     i(0),
--     t({ "", "}" }),
--   }),
-- })
-- ---}}}
