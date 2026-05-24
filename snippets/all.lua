local ls = require("luasnip")
local s, i, t, f = ls.snippet, ls.insert_node, ls.text_node, ls.function_node

local function comment_start()
  local cs = vim.bo.commentstring
  return (cs:match("^(.-)%s*%%s") or ""):gsub("%s+$", "")
end

local function comment_end()
  return vim.bo.commentstring:match("%%s(.*)$") or ""
end

return {
  s("modeline", {
    f(comment_start), t(" vim: set "), i(1, "ft="), t(":"), f(comment_end),
  }),
}
