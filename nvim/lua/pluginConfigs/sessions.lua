-- :SearchSession - fuzzy find sessions with telescope

local key_mapper = require('utils.key_mapper')

require('auto-session').setup({
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
})

require('session-lens').setup({})
