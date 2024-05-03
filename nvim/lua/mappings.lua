local key_mapper = require("utils.key_mapper")

--Remap space as leader key
key_mapper("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
key_mapper("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
key_mapper("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

--Remap escape to leave terminal mode
key_mapper("t", "<Esc>", [[<c-\><c-n>]], { noremap = true })

-- Y yank until the end of line
key_mapper("n", "Y", "y$", { noremap = true })

-- Map J-K to escape
-- using better-escape
-- key_mapper('i', 'jk', "<Esc>")

-- easily clear highlighted search - :noh
key_mapper("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlighted search" })

-- Strip all whitespace from file
key_mapper("n", "<leader>W", [[:%s/\s\+$//<cr>:let @/=''<CR>]], { desc = "Strip whitespace" })

-- re-hardwrap paragraph
key_mapper("n", "<leader>q", "gqip", { desc = "Hardwrap paragraph" })

-- reselect recent pasted text
key_mapper("n", "<leader>v", "`[v`]")

-- Quickly select entire file
key_mapper("n", "<leader>sa", "ggVG")

-- Quickly open vimrc in new splits
key_mapper("n", "<leader>ev", ":vs $MYVIMRC<CR>")
key_mapper("n", "<leader>eV", ":split $MYVIMRC<CR>")

-- vim fugitive shortcuts
key_mapper("n", "<leader>gs", ":Git<CR>")
key_mapper("n", "<leader>gd", ":Gdiff<CR>")
vim.cmd([[cnoreabbrev gb GBrowse]])

-- Copy current filename to clipboard

local copy_filename = function()
  local current_file_name = vim.fn.expand("%")

  vim.fn.setreg("*", current_file_name, "c")
  vim.notify("Copying filname to clipboard " .. current_file_name)
end

vim.keymap.set("n", "<leader>cfn", copy_filename, { noremap = true })


-- easily interact with system clipboard
key_mapper("n", "<leader>p", '"*p')
key_mapper("v", "<leader>p", '"*p')
key_mapper("n", "<leader>P", '"*P')
key_mapper("v", "<leader>P", '"*P')
key_mapper("v", "<leader>y", '"*y')
key_mapper("v", "<leader>d", '"*d')

-- use vim magic mode instead of weird regexes
key_mapper("n", [[/]], [[/\V]], { noremap = true })
key_mapper("v", [[/]], [[/\V]], { noremap = true })
key_mapper("n", [[?]], [[?\V]], { noremap = true })
key_mapper("v", [[?]], [[?\V]], { noremap = true })

-- automatically position cursor to middle of screen after searching
key_mapper("n", "n", "nzzzv")
key_mapper("n", "N", "Nzzzv")

-- move to beginning/end of line easier
key_mapper("n", "H", "^")
key_mapper("n", "L", "$")
key_mapper("v", "H", "^")
key_mapper("v", "L", "$")

--  :vsp - new buffer vertically
--  :sp - new buffer horizontally
--  remap changing buffers
key_mapper("n", "<C-h>", "<C-w>h")
key_mapper("n", "<C-j>", "<C-w>j")
key_mapper("n", "<C-k>", "<C-w>k")
key_mapper("n", "<C-l>", "<C-w>l")

-- Don't copy the replaced text after pasting in visual mode
key_mapper("v", "p", '"_dP')

vim.cmd([[ command! HighlightGroups execute ':so $VIMRUNTIME/syntax/hitest.vim' ]])

-- Easily start profiling actions
vim.cmd("silent! command StartProfile :profile start ~/profile.log | :profile func * | :profile file *<CR>")
-- to stop profiling -- :profile stop
