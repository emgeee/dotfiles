-- Configure the UI
-- Requires a patched font from https://www.nerdfonts.com/
-- Currently using RobotoMono
-- configure Iterm>Profile>Non ASCII font

vim.wo.number = true --Make line numbers default
vim.o.relativenumber = true --Relative line numbers
vim.o.splitright = true --configure verticle splits to open to the right of the current buffer
vim.o.scrolloff = 4 --keep minimum of 4 lines between cursor and end of screen
vim.o.cursorline = true --highlight entire line cursor is on

-- Disable cursorline when leaving a buffer
vim.cmd([[
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
]])

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.g.onedark_style = 'deep'

-- https://github.com/navarasu/onedark.nvim
require('onedark').setup()

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
