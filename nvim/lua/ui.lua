-- Configure the UI
-- Requires a patched font from https://www.nerdfonts.com/
-- Currently using RobotoMono
-- configure Iterm>Profile>Non ASCII font

vim.wo.number = true --Make line numbers default
vim.o.relativenumber = true --Relative line numbers
vim.o.splitright = true --configure verticle splits to open to the right of the current buffer
vim.o.scrolloff = 4 --keep minimum of 4 lines between cursor and end of screen
vim.o.cursorline = false --highlight entire line cursor is on

-- Disable cursorline when leaving a buffer
-- vim.cmd([[
-- augroup CursorLine
--   autocmd!
--   autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
--   autocmd WinLeave * setlocal nocursorline
-- augroup END
-- ]])

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.g.onedark_style = 'deep'

-- https://github.com/navarasu/onedark.nvim
require('onedark').setup()

local config = {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {{'filename', color="WarningMsg", path=1}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', color="Title", path=1}},
    lualine_x = {{'location', color="Title"}},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fzf', 'quickfix', 'fugitive'}
}

--  require('utils.get-function-name')

-- The following functions are pulled from https://gist.github.com/hoob3rt/b200435a765ca18f09f83580a606b878
-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- WIP
-- ins_right {
--   function() return require('nvim-treesitter').statusline({indicator_size=20}) end
-- }

ins_right {
  'filetype'
}
ins_right {
  'progress'
}
ins_right {
  'location'
}


require('lualine').setup(config)

-- File Tree config
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  { key = "?", cb = tree_cb("toggle_help") },
}
-- We need to keep netrw enabled so :GBrowse will work!
vim.g.nvim_tree_disable_netrw = 0

local key_mapper = require('utils.key_mapper')

key_mapper('n', '<F3>', ':NvimTreeToggle<CR>')
key_mapper('n', '<F4>', ':NvimTreeFindFile<CR>')


-- nvim window
require('nvim-window').setup({
  -- Specify a customer Highlight groups
  -- use :so $VIMRUNTIME/syntax/hitest.vim to view highligh groups
  normal_hl = 'Search',
  hint_hl = 'Bold',
  border = 'none',
})

vim.cmd([[ command! HighlightGroups execute ':so $VIMRUNTIME/syntax/hitest.vim' ]])

key_mapper('', '<C-e>', [[:lua require('nvim-window').pick()<CR>]], {silent=true})
