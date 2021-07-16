local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

-- WIP this doesn't really work yet
function M.get_current_function_name()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return ""
  end

  local expr = current_node

  while expr do
    print(expr)
      if expr:type() == 'function_declaration' then
          break
      end
      expr = expr:parent()
  end

  if not expr then
    return ""
  end

  local name = (ts_utils.get_node_text(expr:child(1)))[1]
  print(name)
  return name
end

return M
