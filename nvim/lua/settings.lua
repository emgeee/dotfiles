
--Incremental live completion
vim.o.inccommand = "nosplit"

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd[[set undofile]]

--Decrease update time
vim.o.updatetime = 250

-- Use separate sign and number columns
vim.wo.signcolumn="yes"

-- Don't pass messages to |ins-completion-menu|.
-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

-- Set completeopt to have a better completion experience
vim.o.completeopt="menuone,noinsert"

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = {'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'

-- Change preview window location
vim.g.splitbelow = true
vim.g.splitright = true

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)


-- Save line postion on exit, then restore when opening file
vim.cmd([[
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
]], false)



-- options for searching
vim.o.hlsearch = true --highlight all matches
vim.o.incsearch = true --incremently start searching before hitting enter
vim.o.ignorecase = true --ignore case
vim.o.smartcase = true --ignore case when only lower case
vim.o.gdefault = true --default to global search+replace


--  used for viewing lines that are so long they take up the entire screen at
--  once when wrapped
vim.o.display = 'lastline'

vim.o.tabstop = 2 --size of a hard tabstop
vim.o.shiftwidth = 2 --size of an indent (used for << and >>)
vim.o.shiftround = true --round to nearest shiftwidth
vim.o.expandtab = true --Expand TABs to spaces
vim.o.joinspaces = false -- No double spaces with join

-- a combination of spaces and tabs are used to simulate tab stops at a width
-- other than the (hard)tabstop
vim.o.softtabstop = 2

-- Ignore these directories
vim.o.wildmode = 'list:longest,full'
vim.o.wildmenu = true

vim.opt.wildignore = {
  '*/tmp/*,*.so,*.swp,*.zip',
  '*/out/*',
  '*/vendor/*',
  '*/plugins/*',
  '*.o,*.obj,*~',
  'DS_Store',
  '*.png,*.jpg,*.gif',
  '*.pyc',

  'public',
  'submodules',
  'node_modules',
  'bower_components',
  'www',

  -- 'bazel-bin/*',
  -- 'bazel-monorepo/*',
  'bazel-out/*',
  'bazel-testlogs/*',
  'fakes/*',
}

vim.g.rooter_patterns = {'.git'}

