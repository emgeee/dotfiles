local opt = vim.opt
local g = vim.g

-- Configure the UI
-- Requires a patched font from https://www.nerdfonts.com/
-- Currently using RobotoMono
-- configure Iterm>Profile>Non ASCII font
vim.g.neovide_cursor_animation_length=0
vim.g.neovide_scroll_animation_length = 0.1


vim.wo.number = true --Make line numbers default
opt.relativenumber = true --Relative line numbers
opt.splitright = true --configure verticle splits to open to the right of the current buffer
opt.scrolloff = 4 --keep minimum of 4 lines between cursor and end of screen
opt.cursorline = false --highlight entire line cursor is on

-- set shell to bash for running commands since it's faster than fish
-- opt.shell = "/bin/bash"

opt.lazyredraw = true

opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"

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
vim.wo.signcolumn="auto:2"

-- Don't pass messages to |ins-completion-menu|.
-- Avoid showing message extra message when using completion
opt.shortmess = vim.o.shortmess .. "c"

-- Change preview window location
g.splitbelow = true
g.splitright = true


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
  'target/*',
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
	"matchit",
  -- "matchparen",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

-- Don't show status line on vim terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber laststatus=0 ]]

-- Highlight on yank
vim.cmd([[
augroup YankHighlight
autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]], false)

-- Recommend by auto-session plugin
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- HACK: treat avro files as JSON files
vim.cmd([[
autocmd BufNewFile,BufRead *.avro set ft=json
]])

