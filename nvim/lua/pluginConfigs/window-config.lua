
local key_mapper = require('utils.key_mapper')

require('nvim-window').setup({
  -- Specify a custom Highlight groups
  -- use :so $VIMRUNTIME/syntax/hitest.vim to view highlight groups
  normal_hl = 'Search',
  hint_hl = 'Bold',
  border = 'none',
})

key_mapper('', '<C-e>', [[:lua require('nvim-window').pick()<CR>]], {silent=true})
