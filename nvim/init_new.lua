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
--  M - jump cursor to middle of display "
--
--  :ju(mp) - print jump list
--
--  brew install the_silver_searcher fzf bat fd

-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'       -- Package manager

  -- LSP config
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'

  --CoC
  use {'neoclide/coc.nvim', branch='release'}

  -- Install treesitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/playground'}

  -- Status line plugin
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }


  -- Git commands
  use 'tpope/vim-fugitive'           -- Git commands in nvim
  use 'tpope/vim-rhubarb'            -- Fugitive-companion to interact with github


  -- Simply sets the root directory
  use 'airblade/vim-rooter'

  use {'bazelbuild/vim-bazel', requires = {'google/vim-maktaba'}}

  -- surround things
  -- ys<text object><surround char> - wrap text object
  -- cs<old char><new char> - Change Surround
  -- ds<old char> - Delete Surround
  -- In virtual mode - S<char> - wrap current selection in <char>
  use 'tpope/vim-surround'

  use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'

  -- Enable editorconfig in vim
  use 'editorconfig/editorconfig-vim'

  -- Comment plugin
  use 'tomtom/tcomment_vim'
  -- Press <c-_><c-_> to comment lines
  -- Press <c-_>i for inline commenting

  -- Add git related info in the signs columns and popups
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }

  -- use 'tpope/vim-commentary'         -- "gc" to comment visual regions/lines
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management

  -- UI to select things (files, grep results, open buffers...)
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }

  -- Session management
  use {'rmagatti/auto-session'}
  use {'rmagatti/session-lens', requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'}}

  use {'https://gitlab.com/yorickpeterse/nvim-window.git'}

  -- still use fzf until we learn telescope and it becomes fast
  use { 'junegunn/fzf' }
  use 'junegunn/fzf.vim'

  use 'jremmen/vim-ripgrep'
  use 'mileszs/ack.vim'

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Autocompletion plugin
  use 'hrsh7th/nvim-compe'

  use 'kyazdani42/nvim-tree.lua'

  -- Themes
  use 'navarasu/onedark.nvim'
end)

require('settings')
require('maps')
require('ui')
require('coc')
require('lsp')
require('autocomplete')
require('treesitter')
require('telescope-config')
require('fzf')
require('grep')
require('sessions')
require('git')
