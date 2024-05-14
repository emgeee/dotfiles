local key_mapper = require("utils.key_mapper")

--Remap space as leader key
key_mapper("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
key_mapper("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
key_mapper("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

function _G.set_terminal_keymaps()
	local opts = { buffer = 0, silent = true }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Y yank until the end of line
key_mapper("n", "Y", "y$", { noremap = true })

-- Map J-K to escape
-- using better-escape
-- key_mapper('i', 'jk', "<Esc>")

-- easily clear highlighted search - :noh
key_mapper("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear highlighted search" })

-- Strip all whitespace from file
key_mapper("n", "<leader>W", [[:%s/\s\+$//<cr>:let @/=''<CR>]], { noremap = true, silent = true, desc = "Strip whitespace" })

-- re-hardwrap paragraph
key_mapper("n", "<leader>q", "gqip", { noremap = true, silent = true, desc = "Hardwrap paragraph" })

-- reselect recent pasted text
key_mapper("n", "<leader>v", "`[v`]", { noremap = true, silent = true, desc = "Reselect recently pasted text" })

-- Quickly select entire file
key_mapper("n", "<leader>sa", "ggVG", { noremap = true, silent = true, desc = "Select all text in file" })

-- Copy current filename to clipboard
local copy_filename = function()
	local current_file_name = vim.fn.expand("%")

	vim.fn.setreg("*", current_file_name, "c")
	vim.notify("Copying filname to clipboard " .. current_file_name)
end

vim.keymap.set("n", "<leader>cfn", copy_filename, { noremap = true, silent = true, desc = "Copy filename to clipboard" })

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

-- Buffer cycling mappings defined in tab_bar.lua
-- key_mapper("n", "gb", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
-- key_mapper("n", "gB", ":bprev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Don't copy the replaced text after pasting in visual mode
key_mapper("v", "p", '"_dP')

vim.cmd([[ command! HighlightGroups execute ':so $VIMRUNTIME/syntax/hitest.vim' ]])

-- Easily start profiling actions
vim.cmd("silent! command StartProfile :profile start ~/profile.log | :profile func * | :profile file *<CR>")
-- to stop profiling -- :profile stop
