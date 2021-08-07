vim.g.fzf_buffers_jump = 1
vim.g.fzf_layout = { down = '30%' }

--  We use the fd command to list files that are then filtered by FZF
--  This gives us more control over which files are listed. For example
--  fd respects gitignore
vim.cmd([[
  nnoremap <silent> <C-p> :call fzf#run(fzf#wrap({'source': 'fd --type f '}))<CR>
]])

-- Enable closing the FZF window by pressing Esc https://github.com/junegunn/fzf.vim/issues/544
vim.cmd([[
  tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
]])
