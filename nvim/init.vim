
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim tips and commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim quick reference (cheat sheet)
"   :help quickref

" Recommended keys to map custom functionality too
"   :help map-which-keys
"
" List of commands for each mode
"   :help index
"
" M - jump cursor to middle of display "
"
" :ju(mp) - print jump list
"
" brew install the_silver_searcher fzf bat fd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:editor_root=expand("~/.config/nvim")

set shell=bash "needed to make plugins work in fish shell

filetype off                  " required!

call plug#begin(s:editor_root . '/plugged')

Plug 'google/vim-maktaba'


""""""""""""""""""""""""""""""
""" Themes
""""""""""""""""""""""""""""""
Plug 'altercation/vim-colors-solarized'
Plug 'trapd00r/neverland-vim-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'romainl/flattened'


""""""""""""""""""""""""""""""
" Fuzzy file search
""""""""""""""""""""""""""""""
" Plug 'ctrlpvim/ctrlp.vim'
"
" " Set no max file limit
" let g:ctrlp_max_files = 0
" " Search from current directory instead of project root
" let g:ctrlp_working_path_mode = 'ra'
" " let g:ctrlp_cmd = "CtrlPMixed"
" "

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '30%' }



" We use the fd command to list files that are then filtered by FZF
" This gives us more control over which files are listed. For example
" fd respects gitignore
nnoremap <silent> <C-p> :call fzf#run(fzf#wrap({'source': 'fd --type f '}))<CR>
" nnoremap <silent> <C-p> :<C-u>FZF<CR>

" Enable closing the FZF window by pressing Esc https://github.com/junegunn/fzf.vim/issues/544
if has("nvim")
  au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au! FileType fzf tunmap <buffer> <Esc>
endif

" if has('nvim') && !exists('g:fzf_layout')
"   autocmd! FileType fzf
"   autocmd  FileType fzf set laststatus=0 noshowmode noruler
"     \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" endif

""""""""""""""""""""""""""""""
""" Autocomplete
""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


""""""""""""""""""""""""""""""
""" JavaScript / Web
""""""""""""""""""""""""""""""
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
let g:javascript_plugin_jsdoc = 1 " Syntax highlighting for JsDoc
let g:javascript_plugin_flow = 1 " Syntax highlighting for Flowtype

" Adds some addition syntax highlighting
Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
"" configure javascript libraries syntax
let g:used_javascript_libs = 'underscore,jquery,react,ramda'

" Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
"
" TypeScript Syntax highlighting
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

" Plugin connects to Typescript server for information
" Plug 'Quramy/tsuquyomi', { 'for': ['typescript'] }

Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
let g:jsx_ext_required = 0

Plug 'elzr/vim-json', { 'for': ['json'] }
let g:vim_json_syntax_conceal = 0

"" Highligh css colors!
Plug 'ap/vim-css-color'
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'groenewege/vim-less'

"" vim keybindings for require
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
" gF to go to required() file

"" Hot key to auto add import statements
" Requires 'npm install -g import-js'
Plug 'galooshi/vim-import-js', { 'for': ['javascript', 'javascript.jsx'] }

""""""""""""""""""""""""""""""
""" Python
""""""""""""""""""""""""""""""
Plug 'vim-python/python-syntax', { 'for': ['python']}
let g:python_highlight_all = 1

let g:python_highlight_string_format = 1
let g:python_highlight_builtins = 1
let g:python_highlight_class_vars = 1
let g:python_highlight_operators = 1

Plug 'tmhedberg/SimpylFold', { 'for': ['python']}
let g:SimplyFold_fold_docstring=0

" Don't fold anything by default
set foldlevelstart=999

" Folds
" zM - close all folds
" zm - close all folds by level
" zR - open all folds
" zr - open all folds by level
"
" za - open fold
" zc - close fold
"
"

""""""""""""""""""""""""""""""
""" golang
""""""""""""""""""""""""""""""

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Allow sharing the same gopls daemon with other vim instances + coc
" The gopls service needs to be manually started!
let g:go_gopls_options = ['-remote=unix;/tmp/gopls-daemon-socket']

" Disable vim-go gopls integration since those features are covered by CoC and we mostly want
" syntax highlighting. https://github.com/josa42/coc-go/issues/76 has suggestions for a fix if
" it's a problem
" let g:go_gopls_enabled = 0

" disable vim-go :GoDef and :GoDoc shortcuts since these are better handled by CoC
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0

let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_variable_declarations = 0

Plug 'bazelbuild/vim-bazel'

""""""""""""""""""""""""""""""""""""""""""
"" Use ag (the silver searcher) to find patterns in file
Plug 'mileszs/ack.vim'

" Optionally use silver Searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Normal "Ack" jumps to the first result automatically, "Ack!" does not
" so default to not jumping
cnoreabbrev Ack Ack!

Plug 'jremmen/vim-ripgrep'

set grepprg=rg\ --vimgrep\ --smartcase
set grepformat=%f:%l:%c:%m

""""""""""""""""""""""""""""""""""""""""""

" :Ag [options] {pattern} [{directory}]
" must escape # character with \
" e    to open file and close the quickfix window
" o    to open (same as enter)
" go   to preview file (open but maintain focus on ag.vim results)
" t    to open in new tab
" T    to open in new tab silently
" h    to open in horizontal split
" H    to open in horizontal split silently
" v    to open in vertical split
" gv   to open in vertical split silently
" q    to close the quickfix window

"" Split/join certain control statements
" gS - split one-liner into multiple lines
" gJ - join block in single line
Plug 'AndrewRadev/splitjoin.vim'

"" File navigation sidebar
Plug 'scrooloose/nerdtree'
" type :NERDTreeToggle
" :NERDTreeFind find location of current file
" i to open in new split
" s to open in new vsplit
" t to open in new tab
" p go to parent directory
" m to open menu

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI = 1

let NERDTreeIgnore=[
  \ 'bazel-bin/*',
  \ 'bazel-monorepo/*',
  \ 'bazel-out/*',
  \ 'bazel-testlogs/*',
  \ ]

"" Easily jump around
Plug 'Lokaltog/vim-easymotion'
" Press <leader><leader> then a move command where <leader> = '\'
"
let g:EasyMotion_leader_key = '<leader><leader>'

"" Comment plugin
Plug 'tomtom/tcomment_vim'
" Press <c-_><c-_> to comment lines
" Press <c-_>i for inline commenting
"

"" Beautify HTML, css, and js
"" requires ~/.vim/.editorconfig
" Plug 'einars/js-beautify'
Plug 'maksimr/vim-jsbeautify'
" :call JsBeautify()
" :call HtmlBeautify()
" :call CSSBeautify()
"

"" Allow custom text objects
Plug 'kana/vim-textobj-user'

"" Custom text object for XML attributes
Plug 'whatyouhide/vim-textobj-xmlattr'
" ax and ix
"

"" Custom text object for indent blocks
Plug 'michaeljsmith/vim-indent-object'
" ai aI - full indentiation
" ii, iI - inner indentation (effectively the same)

"" Allow jumping between indent levels
Plug 'jeetsukumaran/vim-indentwise'
" [-, ]-
" [=, ]=
" [+, ]+
"

"" Enable editorconfig in vim
Plug 'editorconfig/editorconfig-vim'


"" Easily surround things
Plug 'tpope/vim-surround'
" ys<text object><surround char> - wrap text object
" cs<old char><new char> - Change Surround
" ds<old char> - Delete Surround
" In virtual mode - S<char> - wrap current selection in <char>


"" Automatically added closing parenthesis/brackets etc
Plug 'Raimondi/delimitMate'

""""""""""""""""""""""""""""""
" Git stuff
""""""""""""""""""""""""""""""
"" Manage git inside vim
Plug 'tpope/vim-fugitive'
" dp
" do

"" Adds some Github specific bindings
" :Gbrowse to open repo in Github
Plug 'tpope/vim-rhubarb'

"" Display git diffs in sidebar
Plug 'airblade/vim-gitgutter'

"" random key mappings
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'

"" Give me a powerline style status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Highlight matching tags
Plug 'Valloric/MatchTagAlways'

"" Show contents of buffers when pasting
Plug 'junegunn/vim-peekaboo'


""""""""""""""""""""""""""""""
" => Dash.vim
""""""""""""""""""""""""""""""
"" Search Dash documentation
" Plug 'rizzatti/dash.vim'
" nnoremap <silent> <leader>d <Plug>DashSearch

"" Experimental (not necessarily in workflow)
" Plug 'tpope/vim-sleuth'
" Plug 'mbbill/undotree'

Plug 'mg979/vim-visual-multi'
" ctrl+n

"" Track usage with Wakatime
" Plug 'wakatime/vim-wakatime'

"" Align text around auto columns
Plug 'junegunn/vim-easy-align'

"" configure tern - the javascript autocompleter
" Plug 'marijnh/tern_for_vim'
" remember to `npm install` in package directory

"" Syntax checker
" Plug 'scrooloose/syntastic'
" :Errors - show quickfix window

""""""""""""""""""""""""""""""
" => neomake
""""""""""""""""""""""""""""""
" Plug 'neomake/neomake'
" let g:neomake_javascript_enabled_makers = ['standard']
" let g:neomake_jsx_enabled_makers = ['standard']
"
" autocmd! BufWritePost * Neomake
" call neomake#configure#automake('w')

" Plug 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'] }
" let g:flow#flowpath = "./node_modules/.bin/flow"
" let g:flow#autoclose = 1

""""""""""""""""""""""""""""""""
" => ALE Linter
""""""""""""""""""""""""""""""""
Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
" Ale option for python specified in ftplugin/python.vim

" Enable option to only lint on file save (file save linting is enabled by default)
" let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {
\   'javascript': ['standard', 'eslint'],
\   'javascript.jsx': ['standard', 'eslint']
\}
" \   'python': ['flake8', 'mypy', 'pyls']

" let g:ale_linter_aliases = {
" \  'javascript.jsx': 'javascript',
" \  'jsx': 'javascript'
" \}

" let g:ale_fixers = {
"   \ 'javascript': ['eslint']
"   \ }


Plug 'junegunn/rainbow_parentheses.vim'
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]


"" automatic vim session creation + restoration
" :Obsess! to remove the session (so you can start over)
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

execute "let g:prosession_dir='" . s:editor_root . "/session/'"
if !isdirectory(g:prosession_dir)
  call mkdir(g:prosession_dir, "p")
endif

" Plug 'christoomey/vim-tmux-navigator'

Plug 'wesQ3/vim-windowswap'
" <leader>ww to initiate swap
" <leader>ww again to swap


Plug 'airblade/vim-rooter'

call plug#end()            " required

"" Better bracket matching with %
runtime! macros/matchit.vim


" Setup a customer virtual environment called `neovim` for neovim and install
" Install virtual env using pyenv:
" $ pyenv virtualenv neovim  # create the 'neovim' virtualenv'
"
" Activate venv
" $ pyenv activate neovim
"
" ALTERNATE: using pyenv python module by default
" > python -m venv ~/.virtualenvs/neovim
" > source ~/.virtualenvs/neovim/bin/activate.fish
"
" Install plugins
" $ pip install neovim jedi
"
let g:python3_host_prog = $HOME.'/.virtualenvs/neovim/bin/python3'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set shortmess+=I "avoid hitting enter?

set ruler "show line numbers at bottom right
set showcmd "show information about current command in bottom right
set scrolloff=3 "keep minimum of 3 lines between cursor and end of screen
set cursorline "highlight entire line cursor is on
set number "show line numbers by default
set relativenumber "line numbers are show relative to position
set splitright " configure verticle splits to open to the right of the current buffer

augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END



"" options for searching
set hlsearch "highlight all matches
set incsearch "incremently start searching before hitting enter
set ignorecase "ignore case
set smartcase "ignore case when only lower case
set gdefault "default to global search+replace

" set textwidth=79
set formatoptions=qrn1

set mouse=a "enable mouse support
" set mouse=c "disable mouse support

"" Ignore these directories
set wildmode=list:longest,full
set wildmenu

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/out/*
set wildignore+=*/vendor/*
set wildignore+=*/platforms/* "ignore for cordova projects
set wildignore+=*/plugins/*
set wildignore+=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=DS_Store
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc

set wildignore+=public
set wildignore+=submodules
set wildignore+=node_modules
set wildignore+=bower_components
set wildignore+=www
" set wildignore+=*/development/*
" set wildignore+=*/production/*

set wildignore+=bazel-bin/*
set wildignore+=bazel-monorepo/*
set wildignore+=bazel-out/*
set wildignore+=bazel-testlogs/*

"" used for viewing lines that are so long they take up the entire screen at
"" once when wrapped
set display=lastline

set tabstop=2 "size of a hard tabstop
set shiftwidth=2 "size of an indent (used for << and >>)
set shiftround "round to nearest shiftwidth
set expandtab "Expand TABs to spaces

"" a combination of spaces and tabs are used to simulate tab stops at a width
"" other than the (hard)tabstop
set softtabstop=2

"""filetype configurations
au Filetype arduino set autoindent "turn on autoindent for arduino filetype (*.ino)
au BufNewFile,BufRead *.ejs set filetype=html "Interpret .ejs files as html
au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufReadPost *.json set filetype=json
au BufNewFile,BufReadPost *.md,*.mdown,*.markdown set filetype=markdown "Set .md to markdown

" always disable cursor line for markdown
augroup markdown_set_cul
  autocmd FileType markdown :autocmd! markdown_set_cul VimEnter,WinEnter,BufWinEnter <buffer> :setlocal nocul
augroup END

""""""""""""""""""""""""""""""
" => airline
""""""""""""""""""""""""""""""
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_right_alt_sep = ''
" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀t

let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.crypt = '🔒'

" Airline White Space Handling:
let g:airline#extensions#whitespace#enabled = 1
let g:airline_symbols.whitespace = '□□'

" let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_spell=0

" Don't show certain sections
let g:airline_section_x = ''
let g:airline_section_y = ''

let g:airline_mode_map = {
\ '__' : '-',
\ 'n' : 'N',
\ 'i' : 'I',
\ 'R' : 'R',
\ 'c' : 'C',
\ 'v' : 'V',
\ 'V' : 'V',
\ 's' : 'S',
\ 'S' : 'S',
\ '�' : 'S',
\ }

set laststatus=2
set noshowmode



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups, and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" individual filetype indenting can be configured in
" ~/.vim/after/ftplugin/<filetype>.vim
filetype plugin indent on

execute "let s:backupdir='". s:editor_root . "/tmp/backup//'"
execute "let s:directory='" . s:editor_root . "/tmp/swap//'"
execute "let s:undodir='" . s:editor_root . "/tmp/undo//'"

if !isdirectory(s:backupdir)
  call mkdir(s:backupdir, "p")
endif
if !isdirectory(s:directory)
  call mkdir(s:directory, "p")
endif
if !isdirectory(s:undodir)
  call mkdir(s:undodir, "p")
endif

set backup
execute "set backupdir=". s:backupdir
execute "set directory=" . s:directory

set undofile
execute "set undodir=" . s:undodir
set history=700
set undolevels=700


"" Auto save when focus is lost
" au FocusLost * :wa


"" Auto reload the buffer from disk if it has changed when entering
au FocusGained,BufEnter * :silent! !

""" Tell vim to remember certain things when we exit
""  '10  :  marks will be remembered for up to 10 previously edited files
""  "100 :  will save up to 100 lines for each register
""  :20  :  up to 20 lines of command-line history will be remembered
""  %    :  saves and restores the buffer list
""  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.nviminfo


"" Save line postion on exit, then restore when opening file
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


"" autoreload vimrc after save
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors, themes, and fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

" enable 24 bit color
set termguicolors

"" Automatically highlight @todo
augroup HighlightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', '@todo', -1)
augroup END

set background=dark
" colorscheme solarized
colorscheme jellybeans
" colorscheme base16-default-dark
" colorscheme flattened_dark
" colorscheme neverland

" let g:airline_theme = 'wombat'
" let g:airline_theme = 'jellybeans'
" let g:airline_theme = 'powerlineish'
" let g:airline_theme = 'solarized'
let g:airline_theme = 'papercolor'
highlight clear SignColumn

" set t_Co=256 "enable 256 colors


"" Highlight trailing whitespace in vim only (not vimpager or Unite window)
if ! exists("vimpager")
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd BufWinLeave * if &modifiable && &ft!='unite' | call clearmatches() | endif
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keyboard remappings
"    use `:help index` to view default bindings
"    use :map to view list of bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<F2>


"" Remap leader key to space
let mapleader = "\<Space>"

"" Map J-K to escape
inoremap jk <Esc>

"" easily clear highlighted search - :noh
nnoremap <silent> <leader>h :nohlsearch<CR>

"" Strip all whitespace from file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"" re hardwrap paragraph
nnoremap <leader>q gqip

"" reselect recent pasted text
nnoremap <leader>v V`]

"" Quickly open vimrc in new splits
nnoremap <leader>ev :vs $MYVIMRC<CR>
nnoremap <leader>eV :split $MYVIMRC<CR>

"" Quickly select entire file
nnoremap <leader>sa ggVG

"" Quickly do a full grep for the word under the curosr
nnoremap <leader>sw :Ack! <cword><CR>

"" vim fugitive shortcuts
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

"" Copy curent filename to clipboard
if system('uname -r') =~ "Microsoft"
  "" For WSL in windows use a different utility
  nnoremap <leader>cfn :!echo % \| clipcopy<CR>
else
  nnoremap <leader>cfn :!echo % \| pbcopy<CR>
endif

"" easily interact with system clipboard
noremap <leader>p "*p
noremap <leader>P "*P
vnoremap <leader>y "*y
vnoremap <leader>d "*d

"" Toggle line numbers easily
function! ToggleLineNumbers()
    if &relativenumber
      set number!
      set relativenumber!
    else
      set number "show line numbers by default
      set relativenumber "line numbers are show relative to position
    endif
endfunction

noremap <leader>tn :call ToggleLineNumbers()<CR>

"" Toggle NERDTree
nnoremap <silent> <F3> :NERDTreeToggle<CR>

"" Find current file in NERDTree
nnoremap <silent> <F4> :NERDTreeFind<CR>

"" Automatically standard format a file
nnoremap <silent> <F6> :!standard-format % -w<CR>

"" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vnoremap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

"" remap tab key to % for jumping to matching brackets
nnoremap <tab> %
vnoremap <tab> %

"" use vim magic mode instead of weird regexes
nnoremap / /\V
vnoremap / /\V

nnoremap ? ?\V
vnoremap ? ?\V
"" automatically position cursor to middle of screen after searching
nnoremap n nzzzv
nnoremap N Nzzzv

"" move to beginning/end of line easier
noremap H ^
noremap L $

"" Navigate wrapped lines (display lines) as you'd expect
nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap <silent> k gk

"" Toggle folds with enter
" noremap <silent> <Enter> za
noremap <silent> <leader><Enter> zMza

" Not really sure what is overwriting <C-i> but unmap it
unmap <C-i>

" Allow use of the backspace key at anytime in insert mode
set backspace=indent,eol,start

"" allow us to toggle transparency of gui!
if has('gui_running')
  function! ToggleTransparency()
    if &transparency ==? 0
      set transparency=17
    else
      set transparency=0
    endif
  endfunction

  map <D-u> :call ToggleTransparency()<CR>
endif

" :vsp - new buffer vertically
" :sp - new buffer horizontally
"" remap changing buffers
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" NeoVim terminal emulation
" tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

let g:tmux_navigator_no_mappings = 1

" Keymappings for vim-tmux-navigator
" nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
