"" Highlight "self" as special (used in Javascript)

augroup HighlightSelf
  autocmd!
  autocmd VimEnter,BufEnter,WinEnter *.js :silent! syntax keyword jsThis self
augroup END
