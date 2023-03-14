-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--  => General Vim tips and commands
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--  vim quick reference (cheat sheet)
--    :help quickref
--
--  Recommended keys to map custom functionality too
--    :help map-which-keys
--
--  List of commands for each mode
--    :help index
--
--  Healthcheck
--    :checkhealth
--
--  buffers
--  :bd --> deletes a buffer
--  :%bd --> deletes all open buffers
--
--  M - jump cursor to middle of display
--
--  :ju(mp) - print jump list
--
--  brew install the_silver_searcher fzf bat fd
--
--  Commands to run to update things
--  :Lazy --> open Lazy UI
--  :TSUpdate --> Update treesitter configs
--  :MasonToolsUpdate --> Update LSP servers
--
--  List of interesting plugins:
--  https://github.com/rockerBOO/awesome-neovim
--  https://neovimcraft.com/
--
--  Plugins to investigate
--  https://github.com/simrat39/symbols-outline.nvim
--  https://github.com/echasnovski/mini.nvim#miniindentscope
--  https://github.com/folke/which-key.nvim
--
-- To print variables
--  print(vim.inspect(x))
--

require("mappings")
require("settings")
require("grep")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
