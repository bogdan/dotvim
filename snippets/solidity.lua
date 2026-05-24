local ls = require("luasnip")
local s, i, t, d, sn = ls.snippet, ls.insert_node, ls.text_node, ls.dynamic_node, ls.snippet_node
local h = require("snippet_helpers")

local function dflt(n, fn)
  return d(n, function() return sn(nil, { i(1, fn()) }) end)
end

return {
  s("con", {
    t({
      "// SPDX-License-Identifier: UNLICENSED",
      "pragma solidity ^0.8.28;",
      "", "",
      "contract ",
    }),
    dflt(1, h.spec_name),
    t({ " {", "\t" }), i(2), t({ "", "}" }),
  }),
}
