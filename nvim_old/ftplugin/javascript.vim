setlocal tabstop=2 " show existing tabs with 4 space width
setlocal shiftwidth=2 " indent 4 spaces
setlocal expandtab " expand tabs to spaces

"" Highlight "self" as special (used in Javascript)
augroup HighlightSelf
  autocmd!
  autocmd VimEnter,BufEnter,WinEnter *.js :silent! syntax keyword jsThis self
augroup END
