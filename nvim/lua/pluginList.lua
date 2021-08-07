-- https://github.com/siduck76/NvChad/blob/main/lua/pluginList.lua
local present, _ = pcall(require, 'packerInit')
local packer

if present then
	packer = require 'packer'
else
	return false
end

local use = packer.use

return packer.startup(
	function()
		use {
			'wbthomason/packer.nvim',
			event = 'VimEnter'
		}

		use {
			'jdhao/better-escape.vim',
			event = 'InsertEnter',
			config = function()
				vim.g.better_escape_interval = 300
				vim.g.better_escape_shortcut = {'jk'}
			end
		}

		-- Treesitter
		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			event = 'BufRead',
			config = function()
				require 'plugins.treesitter'
			end
		}
		use {
			'nvim-treesitter/nvim-treesitter-textobjects',
			after = 'nvim-treesitter',
		}
		use {
			'nvim-treesitter/playground',
			after = 'nvim-treesitter',
		}


		-- LSP
		use {
			'kabouzeid/nvim-lspinstall',
			event = 'BufEnter'
		}

		use {
			'neovim/nvim-lspconfig',
			after = 'nvim-lspinstall',
			config = function()
				require 'plugins.lspconfig'
			end
		}

		use {
			'hrsh7th/nvim-compe',
			event = 'InsertEnter',
			config = function()
				require 'plugins.compe'
			end
		}

		--CoC
		use {
			'neoclide/coc.nvim',
			branch = 'release',
			ft = 'go',
			config = function()
				require 'plugins.coc-config'
			end
		}


		-- UI to select things (files, grep results, open buffers...)
		use {
			'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
			config = function()
				require('plugins.telescope-config')
			end
		}

		use {
			'nvim-telescope/telescope-media-files.nvim',
		}

		-- fzf
		use {
			'junegunn/fzf',
			config = function()
				require('plugins.fzf')
			end
		}
		use {
			'junegunn/fzf.vim',
		}


		-- Session management
		use {
			'rmagatti/auto-session'
		}
		use {
			'rmagatti/session-lens',
			requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
			after = 'telescope.nvim',
		}

		-- UI Plugins
		use {
			'navarasu/onedark.nvim',
			config = function()
				--Set colorscheme (order is important here)
				vim.o.termguicolors = true
				vim.g.onedark_terminal_italics = 2
				vim.g.onedark_style = 'deep'
				require('onedark').setup()
			end
		}

		use {
			"nvim-lua/plenary.nvim",
		}

		-- Status line plugin
		use {
			'hoob3rt/lualine.nvim',
			requires = {'kyazdani42/nvim-web-devicons', opt = true},
			config = function()
				require 'plugins.lualine-config'
			end
		}

		-- file tree
		use {
			'kyazdani42/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
			  require 'plugins.tree-config'
			end,
		}

		-- Add indentation guides even on blank lines
		use {
			'lukas-reineke/indent-blankline.nvim',
			event = "BufRead",
			config = function()
				require('indent_blankline').setup {
					char = '▏',
					buftype_exclude = {'terminal', 'nofile'},
					filetype_exclude = {"help", "terminal", "dashboard", "packer"},
					use_treesitter = true,
					show_current_context = true,
				}
			end
		}

		-- Navigation
		use {
			'https://gitlab.com/yorickpeterse/nvim-window.git',
			config = function()
				require 'plugins.window-config'
			end
		}


		-- Automatic tags management
		-- use {
		--   'ludovicchabant/vim-gutentags',
		--   config=function()
		--     require('plugins.gutentags')
		--   end
		-- }

		-- MISC
		use 'airblade/vim-rooter'

		-- surround things
		-- ys<text object><surround char> - wrap text object
		-- cs<old char><new char> - Change Surround
		-- ds<old char> - Delete Surround
		-- In virtual mode - S<char> - wrap current selection in <char>
		use 'tpope/vim-surround'

		use 'tpope/vim-unimpaired'
		use 'tpope/vim-repeat'
		-- use 'tpope/vim-sleuth'             -- Auto detect tabs/spaces

		-- Git commands
		use 'tpope/vim-fugitive'           -- Git commands in nvim
		use 'tpope/vim-rhubarb'            -- Fugitive-companion to interact with github

		-- Enable editorconfig in vim
		use 'editorconfig/editorconfig-vim'

		-- Comment plugin
		use 'tomtom/tcomment_vim'
		-- Press <c-_><c-_> to comment lines
		-- Press <c-_>i for inline commenting


		use {
			'bazelbuild/vim-bazel',
			requires = {'google/vim-maktaba'},
		}

		use {
			'fatih/vim-go',
			ft = 'go',
			config = function()
				require 'plugins.go-config'
			end
		}

		-- Add git related info in the signs columns and popups
		use {
			'lewis6991/gitsigns.nvim',
			requires = {'nvim-lua/plenary.nvim'},
			after = 'plenary.nvim',
			config = function()
				require('gitsigns').setup()
			end
		}
	end
)
