local ls = require("luasnip")
local s, i, t, f = ls.snippet, ls.insert_node, ls.text_node, ls.function_node
local rep = require("luasnip.extras").rep
local h = require("snippet_helpers")

return {
  s("ghi", {
    t("[#"), i(1), t("]("),
    f(h.repo),
    t("/issues/"), rep(1), t(")"),
  }),
}
