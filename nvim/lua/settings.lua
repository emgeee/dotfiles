local opt = vim.opt
local g = vim.g

-- Configure the UI
-- Requires a patched font from https://www.nerdfonts.com/
-- Currently using RobotoMono
-- configure Iterm>Profile>Non ASCII font

vim.wo.number = true --Make line numbers default
opt.relativenumber = true --Relative line numbers
opt.splitright = true --configure verticle splits to open to the right of the current buffer
opt.scrolloff = 4 --keep minimum of 4 lines between cursor and end of screen
opt.cursorline = false --highlight entire line cursor is on

--Incremental live completion
opt.inccommand = "nosplit"

--Do not save when switching buffers
opt.hidden = true

--Enable mouse mode
opt.mouse = "a"

--Enable break indent
opt.breakindent = true

--Save undo history
vim.cmd[[set undofile]]

--Decrease update time
opt.updatetime = 250

-- Use separate sign and number columns
vim.wo.signcolumn="yes"

-- Don't pass messages to |ins-completion-menu|.
-- Avoid showing message extra message when using completion
opt.shortmess = vim.o.shortmess .. "c"

-- Set completeopt to have a better completion experience
opt.completeopt="menuone,noinsert"

--Map blankline
-- TODO: is this needed with the indent-blankline plugin?
-- g.indent_blankline_char = "┊"
-- g.indent_blankline_filetype_exclude = { 'help', 'packer' }
-- g.indent_blankline_buftype_exclude = {'terminal', 'nofile'}
-- g.indent_blankline_char_highlight = 'LineNr'

-- Change preview window location
g.splitbelow = true
g.splitright = true

-- Highlight on yank
vim.cmd([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]], false)


-- Define the :Browse command - this is needed for vim-rhubarb (provides :GBrowse) to work
-- TODO why doesn't visual selection work?
-- vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])
-- vim.cmd([[ command! -nargs=1 Browse exece "!echo '<args>'" ]])

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
opt.hlsearch = true --highlight all matches
opt.incsearch = true --incremently start searching before hitting enter
opt.ignorecase = true --ignore case
opt.smartcase = true --ignore case when only lower case
opt.gdefault = true --default to global search+replace


--  used for viewing lines that are so long they take up the entire screen at
--  once when wrapped
opt.display = 'lastline'

opt.tabstop = 2 --size of a hard tabstop
opt.shiftwidth = 2 --size of an indent (used for << and >>)
opt.shiftround = true --round to nearest shiftwidth
opt.expandtab = true --Expand TABs to spaces
opt.joinspaces = false -- No double spaces with join

-- a combination of spaces and tabs are used to simulate tab stops at a width
-- other than the (hard)tabstop
opt.softtabstop = 2

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>hl")

-- Ignore these directories
opt.wildmode = 'list:longest,full'
opt.wildmenu = true

opt.wildignore = {
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

	'bazel-bin/*',
	'bazel-monorepo/*',
	'bazel-out/*',
	'bazel-testlogs/*',
	'fakes/*',
}

g.rooter_patterns = {'.git'}

-- disable builtin vim plugins
local disabled_built_ins = {
	-- "netrw",
	-- "netrwPlugin",
	-- "netrwSettings",
	-- "netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit"
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end


-- Don't show status line on vim terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber laststatus=0 ]]

-- set shell to bash for running commands since it's faster than fish
opt.shell = "/bin/bash"

opt.lazyredraw = true
