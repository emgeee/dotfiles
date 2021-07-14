setlocal tabstop=4 " show existing tabs with 4 space width
setlocal shiftwidth=4 " indent 4 spaces
setlocal expandtab " expand tabs to spaces

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8']
" Fix Python files with autopep8 and yapf.
" let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0
