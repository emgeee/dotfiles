local key_mapper = require('utils.key_mapper')

vim.cmd([[
  set grepprg=rg\ --vimgrep\ --smartcase
  set grepformat=%f:%l:%c:%m
]])

vim.g.rg_highlight= true

-- remove needing to capitolize 'R'
vim.cmd([[cnoreabbrev rg Rg]])

-- key_mapper('n', '<leader>sw', ':Rg<CR>')

-- Quickly do a full grep for the word under the curosr
key_mapper('n', '<leader>sw', ':Ack! <cword><CR>')

-- Optionally use silver Searcher
-- not sure how to check if an executable exists in lua
vim.cmd([[
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
]])

vim.cmd([[cnoreabbrev Ack Ack!]])
vim.cmd([[cnoreabbrev ack Ack!]])
