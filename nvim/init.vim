
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

filetype off                  " required!

call plug#begin(s:editor_root . '/plugged')

""" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'trapd00r/neverland-vim-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'romainl/flattened'

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
let g:jsx_ext_required = 0

Plug 'elzr/vim-json', { 'for': ['json'] }
let g:vim_json_syntax_conceal = 0

"" Highligh css colors!
Plug 'ap/vim-css-color'
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'groenewege/vim-less'

"" Display git diffs in sidebar
Plug 'airblade/vim-gitgutter'

""""""""""""""""""""""""""""""""""""""""""
"" Use ag (the silver searcher) to find patterns in file
" Plug 'rking/ag.vim'
Plug 'mileszs/ack.vim'

" Optionally use silver Searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
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

"" Fuzzy file search
" Plug 'kien/ctrlp.vim'
Plug 'ctrlpvim/ctrlp.vim'


"" Easily jump around
Plug 'Lokaltog/vim-easymotion'
" Press <leader><leader> then a move command where <leader> = '\'
"

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


"" Manage git inside vim
Plug 'tpope/vim-fugitive'
" dp
" do

"" Others
" Plug 'Shougo/vimproc.vim'

"" random key mappings
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'

"" Give me a powerline style status bar
Plug 'bling/vim-airline'

"" Highlight matching tags
Plug 'Valloric/MatchTagAlways'

"" Search Dash documentation
" Plug 'rizzatti/dash.vim'
" mapped to <leader>d


"" Experimental (not necessarily in workflow)
" Plug 'tpope/vim-sleuth'
" Plug 'mbbill/undotree'

Plug 'terryma/vim-multiple-cursors'
" ctrl+n

"" Track usage with Wakatime
Plug 'wakatime/vim-wakatime'

"" Align text around auto columns
Plug 'junegunn/vim-easy-align'

"" configure tern - the javascript autocompleter
" Plug 'marijnh/tern_for_vim'
" remember to `npm install` in package directory

"" Syntax checker
" Plug 'scrooloose/syntastic'
" :Errors - show quickfix window

Plug 'benekastah/neomake'

" Plug 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'] }
" let g:flow#flowpath = "./node_modules/.bin/flow"
" let g:flow#autoclose = 1

Plug 'junegunn/rainbow_parentheses.vim'
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]


"" automatic vim session creation + restoration
" :Obsess! to remove the session (so you can start over)
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

execute "let g:prosession_dir='" . s:editor_root . "/session/'"

"" vim keybindings for require
Plug 'moll/vim-node'
" gF to go to required() file

call plug#end()            " required

"" Better bracket matching with %
runtime! macros/matchit.vim

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


"" Macvim specific settings
if has('gui_running')
  set guioptions-=T "Remove toolbar
  set guioptions-=r "Remove right side scrollbar
  set guioptions-=L "Remove right side scrollbar in NERDTree

  set vb t_vb= "Disable visual bell in mvim
endif


if ! has('gui_running')

  "" Fix timing issue with powerline update statusbar
  " set ttimeoutlen=10
  augroup FastEscape
      autocmd!
      au InsertEnter * set timeoutlen=200 "gimme this ms to enter jk
      au InsertLeave * set timeoutlen=1000
    augroup END
endif


""""""""""""""""""""""""""""""
" => airline
""""""""""""""""""""""""""""""
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Use powerline fonts
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12

"" For screencasting - bump up font size
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h24

" don't show git status
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#ctrlp#show_adjacent_modes = 1

let g:airline_powerline_fonts = 1

" disable showing fileencoding and fileformat
let g:airline_section_y = ''
" disable showing filetype
let g:airline_section_x = airline#section#create_right(['tagbar'])

set laststatus=2
set noshowmode



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups, and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" individual filetype indenting can be configured in
" ~/.vim/after/ftplugin/<filetype>.vim
filetype plugin indent on

set backup
execute "set backupdir=". s:editor_root . "/tmp/backup//"
execute "set directory=" . s:editor_root . "/tmp/swap//"

set undofile
execute "set undodir=" . s:editor_root . "/tmp/undo//"
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
" => Colors and fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on


"" Automatically highlight @todo
augroup HighlightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', '@todo', -1)
augroup END


set background=dark
" colorscheme solarized
colorscheme jellybeans

" colorscheme flattened_dark

"" Find more Airline themes at
"" https://github.com/bling/vim-airline/tree/master/autoload/airline/themes
"" pictures: https://github.com/bling/vim-airline/wiki/Screenshots

" colorscheme neverland
" let g:airline_theme = 'wombat'

" colorscheme jellybeans
" let g:airline_theme = 'dark'

" let g:airline_theme = 'murmur'
let g:airline_theme = 'dark'
highlight clear SignColumn

"" configure javascript libraries syntax
let g:used_javascript_libs = 'underscore,jquery,angularjs,angularui'

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
nmap <silent> <leader>h :nohlsearch<CR>

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
map <leader>p "*p
map <leader>P "*P
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

map <leader>tn :call ToggleLineNumbers()<CR>

"" Toggle NERDTree
nmap <silent> <F3> :NERDTreeToggle<CR>

"" Automatically standard format a file
nmap <silent> <F6> :!standard % --format<CR>

"" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" remap tab key to % for jumping to matching brackets
" nnoremap <tab> %
" vnoremap <tab> %

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
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l


" NeoVim terminal emulation
tnoremap <Esc> <C-\><C-n>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins and utilities
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set shell=bash "needed to make vundle in fish work

""""""""""""""""""""""""""""""
" => Ctrlp config
""""""""""""""""""""""""""""""
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_cmd = "CtrlPMixed"
" let g:ctrlp_custom_ignore = 'mean-tutorial/code'


"" Set easy motion key
let g:EasyMotion_leader_key = '<leader><leader>'



""""""""""""""""""""""""""""""
" => neomake config
""""""""""""""""""""""""""""""
let g:neomake_javascript_enabled_makers = ['standard']
let g:neomake_jsx_enabled_makers = ['standard']

autocmd! BufWritePost * Neomake

""""""""""""""""""""""""""""""
" => Syntastic config
""""""""""""""""""""""""""""""
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_always_populate_loc_list = 1
"
" let g:syntastic_enable_signs = 1
" let g:syntastic_javascript_checkers = ['standard']
"
" let g:syntastic_html_tidy_exec = 'tidy5'
" " let g:syntastic_html_tidy_ignore_errors=['proprietary attribute', '<input> proprietary attribute "role"' ]
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]
"
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '!'


""""""""""""""""""""""""""""""
" => beautifier.vim
""""""""""""""""""""""""""""""
" let g:editorconfig_Beautifier = expand('$HOME/.editorconfig')

""""""""""""""""""""""""""""""
" => Dash.vim
""""""""""""""""""""""""""""""
nmap <silent> <leader>d <Plug>DashSearch


""""""""""""""""""""""""""""""
" => textobj
""""""""""""""""""""""""""""""
" call textobj#user#plugin('markdown', {
" \  'code_a': {
" \    'select': 'amc',
" \    'pattern': '^```\w\+\n\_.\{-}\n\_^```\_$',
" \    'region-type': 'V',
" \  },
" \  'code_i': {
" \    'select': 'imc',
" \    'pattern': '^```\w\+\_$\n\zs\_.\{-}\ze\_^```\_$',
" \    'region-type': 'V',
" \  },
" \ })

" call textobj#user#plugin('markdown', {
" \  'code': {
" \    'pattern': ['\_^```\w+\_$','\_^```\_$'],
" \    'select-a': 'amc',
" \    'select-i': 'imc',
" \    'region-type': 'v',
" \  },
" \ })


" call textobj#user#plugin('markdown', {
" \  'code': {
" \    'select-a': 'amc',
" \    'select-a-function': 'CurrentLineA',
" \    'select-i': 'imc',
" \    'select-i-function': 'CurrentLineI',
" \  },
" \ })
"
" function! CurrentLineA()
" endfunction
"
" function! CurrentLineI()
"   let ORIG_POS = getpos('.')[1:2]
"   let start = searchpos('\_^```$', 'bceW')
"   let end = searchpos('\n\_^```$', 'cW')
"
"   return s:cancel_selection(a:previous_mode, ORIG_POS)
" endfunction
