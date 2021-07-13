-- :SearchSession - fuzzy find sessions with telescope

local key_mapper = require('utils.key_mapper')

require('auto-session').setup({
})

require('session-lens').setup({
})

key_mapper('n', '<leader>ss', ":SearchSession<CR>")
