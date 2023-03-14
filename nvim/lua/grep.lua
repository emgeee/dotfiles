vim.cmd([[
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
]])

vim.g.rg_highlight= true

-- remove needing to capitalize 'R'
vim.cmd([[cnoreabbrev rg Rg]])

-- key_mapper('n', '<leader>sw', ':Rg<CR>')

-- Optionally use silver Searcher
-- not sure how to check if an executable exists in lua
vim.cmd([[
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
]])

vim.cmd([[cnoreabbrev Ack Ack!]])
vim.cmd([[cnoreabbrev ack Ack!]])
