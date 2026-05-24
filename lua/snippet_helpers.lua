local M = {}

local function camelcase(s)
  s = s:gsub("^.", string.upper)
  s = s:gsub("_(.)", string.upper)
  return s
end

function M.class_name()
  local name = vim.fn.expand("%:t:r")
  return camelcase(name ~= "" and name or "MyClass")
end

function M.factory_name()
  local name = vim.fn.expand("%:t:r"):gsub("_spec$", ""):gsub("_test$", "")
  return name
end

function M.spec_name()
  local name = vim.fn.expand("%:t:r"):gsub("_spec$", "")
  return camelcase(name ~= "" and name or "MyClass")
end

function M.migration_name()
  local name = vim.fn.expand("%:t:r"):gsub("^.-_", "")
  return camelcase(name ~= "" and name or "MyClass")
end

function M.repo()
  vim.fn.system("git rev-parse --show-toplevel")
  if vim.v.shell_error ~= 0 then return "" end
  local url = vim.fn.system("git config --get remote.origin.url")
  if vim.v.shell_error ~= 0 then return "" end
  url = url:gsub("\n$", "")
  url = url:gsub("git@github.com:", "https://github.com/")
  url = url:gsub("%.git$", "")
  return url
end

return M
