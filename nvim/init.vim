
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



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:editor_root=expand("~/.config/nvim")

set shell=bash "needed to make plugins work in fish shell

filetype off                  " required!

call plug#begin(s:editor_root . '/plugged')


""""""""""""""""""""""""""""""
""" Themes
""""""""""""""""""""""""""""""
Plug 'altercation/vim-colors-solarized'
Plug 'trapd00r/neverland-vim-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'romainl/flattened'


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

" let g:python_highlight_string_format = 1
" let g:python_highlight_builtins = 1
" let g:python_highlight_class_vars = 1
" let g:python_highlight_operators = 1

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

Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim', { 'for': ['python']}
let g:jedi#use_splits_not_buffers = "right"

let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"


" Disable default auto-complete in favor of async deoplete
let g:jedi#completions_enabled = 0


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
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" type :NERDTreeToggle
" :NERDTreeFind find location of current file
" i to open in new split
" s to open in new vsplit
" t to open in new tab
" p go to parent directory
" m to open menu

"" Ctrlsf - Searching and editing strings across multiple files
" EXPERIMENTAL
" Plug 'dyng/ctrlsf.vim'

""""""""""""""""""""""""""""""
" => Ctrlp config
" Fuzzy file search
""""""""""""""""""""""""""""""
Plug 'ctrlpvim/ctrlp.vim'

" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_cmd = "CtrlPMixed"

""""""""""""""""""""""""""""""
""" Autocomplete
""""""""""""""""""""""""""""""
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

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

"" Others
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}

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

Plug 'terryma/vim-multiple-cursors'
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
\   'javascript': ['eslint'],
\   'javascript.jsx': ['eslint']
\}

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

call plug#end()            " required

"" Better bracket matching with %
runtime! macros/matchit.vim


" Setup a customer virtual environment called `neovim` for neovim and install
" pip plugins like jedi, and neovim
"
" let g:python_host_prog = $HOME.'' " Not using python2 for neovim right now
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

set wildignore+=public
set wildignore+=submodules
set wildignore+=node_modules
set wildignore+=bower_components
set wildignore+=www
" set wildignore+=*/development/*
" set wildignore+=*/production/*

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

"" vim fugitive shortcuts
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

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
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


" NeoVim terminal emulation
tnoremap <Esc> <C-\><C-n>
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
