-- Minimal UltiSnips format loader for LuaSnip v2
-- Handles: tabstops, !v vimscript expressions, text, mirrors
-- Regex transforms are simplified to plain mirrors

local M = {}

local function build_nodes(body)
  local ls = require("luasnip")
  local t = ls.text_node
  local i = ls.insert_node
  local f = ls.function_node
  local d = ls.dynamic_node
  local sn = ls.snippet_node
  local rep = require("luasnip.extras").rep

  local nodes = {}
  local used = {}
  local pos = 1
  local len = #body

  local function add_text(text)
    if text ~= "" then
      table.insert(nodes, t(vim.split(text, "\n", { plain = true })))
    end
  end

  while pos <= len do
    -- `!v expr` backtick expression
    if body:sub(pos, pos + 3) == "`!v " then
      local e = body:find("`", pos + 4, true)
      if e then
        local expr = body:sub(pos + 4, e - 1)
        local cap = expr
        table.insert(nodes, f(function()
          local ok, r = pcall(vim.fn.eval, cap)
          return ok and tostring(r) or ""
        end))
        pos = e + 1
      else
        add_text("`!v ")
        pos = pos + 4
      end

    -- ` non-!v backtick (shell cmd) — skip, emit empty
    elseif body:sub(pos, pos) == "`" then
      local e = body:find("`", pos + 1, true)
      pos = e and e + 1 or pos + 1

    -- ${N...} complex tabstop
    elseif body:sub(pos, pos + 1) == "${" then
      local num = body:match("^%${(%d+)", pos)
      if num then
        local n = tonumber(num)
        local after_num = pos + 2 + #num
        local sep = body:sub(after_num, after_num)

        if sep == ":" then
          -- Find matching closing brace (handle nesting)
          local depth, p = 1, after_num + 1
          while p <= len and depth > 0 do
            local c = body:sub(p, p)
            if c == "}" then depth = depth - 1
            elseif c == "{" then depth = depth + 1
            end
            if depth > 0 then p = p + 1 end
          end
          local default = body:sub(after_num + 1, p - 1)
          local v_expr = default:match("^`!v ([^`]+)`$")

          if v_expr then
            local cap, cn = v_expr, n
            if not used[n] then
              used[n] = true
              table.insert(nodes, d(cn, function()
                local ok, r = pcall(vim.fn.eval, cap)
                return sn(nil, { i(1, ok and tostring(r) or "") })
              end))
            else
              table.insert(nodes, rep(cn))
            end
          else
            if not used[n] then
              used[n] = true
              table.insert(nodes, i(n, vim.split(default, "\n", { plain = true })))
            else
              table.insert(nodes, rep(n))
            end
          end
          pos = p + 1

        elseif sep == "/" then
          -- Transform: simplify to plain mirror/insert
          local close = body:find("}", after_num, true)
          if not used[n] then used[n] = true; table.insert(nodes, i(n))
          else table.insert(nodes, rep(n)) end
          pos = (close or len) + 1

        else
          -- ${N} bare
          local close = body:find("}", after_num, true)
          if not used[n] then used[n] = true; table.insert(nodes, i(n))
          else table.insert(nodes, rep(n)) end
          pos = (close or len) + 1
        end
      else
        add_text("${")
        pos = pos + 2
      end

    -- $N simple tabstop
    elseif body:sub(pos, pos) == "$" and body:sub(pos + 1, pos + 1):match("%d") then
      local num = body:match("^%$(%d+)", pos)
      if num then
        local n = tonumber(num)
        if not used[n] then used[n] = true; table.insert(nodes, i(n))
        else table.insert(nodes, rep(n)) end
        pos = pos + 1 + #num
      else
        add_text("$"); pos = pos + 1
      end

    -- Plain text: collect until next recognized special char
    else
      local start = pos
      while pos <= len do
        local c = body:sub(pos, pos)
        if c == "`" then break end
        if c == "$" then
          local nc = body:sub(pos + 1, pos + 1)
          if nc == "{" or nc:match("%d") then break end
        end
        pos = pos + 1
      end
      if pos == start then pos = pos + 1 end  -- always advance to prevent infinite loop
      add_text(body:sub(start, pos - 1))
    end
  end

  return nodes
end

local function load_file(filepath, ft)
  local ls = require("luasnip")
  local s = ls.snippet

  local file = io.open(filepath, "r")
  if not file then return end
  local content = file:read("*all")
  file:close()

  local snippets = {}
  local scan = 1

  while true do
    -- Find "snippet " at start of a line
    local hs, he
    if scan == 1 then
      hs, he = content:find("^snippet ", 1, true)
      if not hs then
        hs, he = content:find("\nsnippet ", scan, true)
        if hs then he = he end
      end
    else
      hs, he = content:find("\nsnippet ", scan, true)
    end
    if not hs then break end

    local hline_end = content:find("\n", he + 1, true) or #content
    local header = content:sub(he + 1, hline_end - 1)

    local body_start = hline_end + 1
    local es, ee = content:find("\nendsnippet", body_start, true)
    if not es then break end

    local body = content:sub(body_start, es - 1)
    scan = ee + 1

    local trigger = header:match("^(%S+)")
    local desc = (header:match('"([^"]*)"') or header:match("^%S+%s+(.-)%s*$") or ""):gsub('"', '')

    if trigger and trigger ~= "" then
      local ok_n, nodes = pcall(build_nodes, body)
      if ok_n and #nodes > 0 then
        local ok_s, snip = pcall(s, { trig = trigger, desc = desc }, nodes)
        if ok_s then
          table.insert(snippets, snip)
        end
      end
    end
  end

  if #snippets > 0 then
    ls.add_snippets(ft, snippets, { key = "ultisnips_" .. ft })
  end
end

function M.load(opts)
  local paths = opts.paths or {}
  if type(paths) == "string" then paths = { paths } end

  for _, path in ipairs(paths) do
    for _, filepath in ipairs(vim.fn.glob(path .. "/*.snippets", false, true)) do
      local ft = vim.fn.fnamemodify(filepath, ":t:r")
      local ok, err = pcall(load_file, filepath, ft)
      if not ok then
        vim.notify("ultisnips_loader: " .. filepath .. ": " .. tostring(err), vim.log.levels.WARN)
      end
    end
  end
end

return M
