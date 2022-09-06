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
			"nvim-lua/plenary.nvim",
		}

    -- Git commands in nvim
		use {
      'tpope/vim-fugitive',
    }
		use {
      'tpope/vim-rhubarb',
    }

		use {
			'jdhao/better-escape.vim',
			event = 'InsertEnter',
			config = function()
				vim.g.better_escape_interval = 300
				vim.g.better_escape_shortcut = {'jk'}
			end
		}

    use {'kevinhwang91/nvim-bqf', ft = 'qf'}

		-- Treesitter
    -- Rune :TSUpdate to update language definitions
		use {
			'nvim-treesitter/nvim-treesitter',
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


		-- LSP and completions
		-- use {
		-- 	'williamboman/nvim-lsp-installer',
		-- }

		use {
			'neovim/nvim-lspconfig',
      requires={
        "williamboman/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "williamboman/mason-lspconfig.nvim",
        "RRethy/vim-illuminate", -- illuminate works under the cursor
      },
			config = function()
				require 'plugins.lspconfig'
			end
		}

    -- Works by combining inputs from different sources to generate autocomplete
		use {
			'hrsh7th/nvim-cmp',
      -- requires a list of different sources
      requires = {
        {
           -- snippets engine
          'hrsh7th/vim-vsnip',
          requires = {'rafamadriz/friendly-snippets'}
        },
        'hrsh7th/cmp-vsnip', -- source for snippets
        'hrsh7th/cmp-nvim-lsp', -- source for builtin lsp
        'hrsh7th/cmp-buffer', -- source for words in buffers
        'hrsh7th/cmp-path', -- source for file system path
        'hrsh7th/cmp-cmdline', -- source for vims cmd line
        'onsails/lspkind.nvim', -- adds vscode-like pictograms to complete menu
      },
			config = function()
				require 'plugins.cmp-config'
			end
		}

    -- Support for linters
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("plugins.null-ls-config")
        end,
    })


		-- UI to select things (files, grep results, open buffers...)
		use {
			'nvim-telescope/telescope.nvim',
			requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzy-native.nvim'},
        {'nvim-telescope/telescope-media-files.nvim'},
        {'junegunn/fzf'},
      },
			config = function()
				require('plugins.telescope-config')
			end
		}

    -- mostly used for a pretty LSP hover functionality
    -- hotkeys specified in lspconfig.lua
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require("lspsaga")

            saga.init_lsp_saga({})
        end,
    })

		use {
			'mileszs/ack.vim',
		}

    --
		-- Session management
    --
		use {
			'rmagatti/auto-session',
      config = function ()
        require('auto-session').setup({})
      end
		}
		use {
			'rmagatti/session-lens',
			requires = {'rmagatti/auto-session'},
			after = 'telescope.nvim',
      config = function ()
        require('session-lens').setup({})
      end
		}

    --
		-- UI Plugins
    --
		use {
			'navarasu/onedark.nvim',
			config = function()
				--Set colorscheme (order is important here)
				vim.o.termguicolors = true
				vim.g.onedark_terminal_italics = 2

				require('onedark').setup({
					style = "deep"
				})
				require('onedark').load()
			end
		}

    -- Status line plugin
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      after = {
        'onedark.nvim',
        'auto-session',
      },
      config = function()
        require 'plugins.lualine-config'
      end
    }
    -- use {
    --   'glepnir/galaxyline.nvim',
    --   branch = 'main',
    --   requires = {'kyazdani42/nvim-web-devicons', opt = true},
    --   config = function()
    --     require('plugins.spaceline')
    --   end,
    -- }

		-- file tree
		use {
			'kyazdani42/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
			  require 'plugins.tree-config'
			end,
		}

    -- :SymbolsOutline to open window
    use {
      'simrat39/symbols-outline.nvim',
      config = function()
        require("symbols-outline").setup({
          keymaps = {
            close = { 'q' }, -- Keep pressing esc by accident so unbind it
          },
        })

        vim.api.nvim_create_user_command("Outline", 'SymbolsOutline', {})
      end,
    }

		-- Add indentation guides even on blank lines
		use {
			'lukas-reineke/indent-blankline.nvim',
			event = "BufRead",
			config = function()
				require('indent_blankline').setup {
					char = '┊',
					buftype_exclude = {'terminal', 'nofile'},
					filetype_exclude = {"help", "terminal", "dashboard", "packer"},
					use_treesitter = true,
					-- show_current_context = true,
				}
			end
		}

		-- Add git related info in the signs columns and popups
		use {
			'lewis6991/gitsigns.nvim',
			requires = {'nvim-lua/plenary.nvim'},
      event = 'BufRead',
			after = 'plenary.nvim',
			config = function()
				require('gitsigns').setup()
			end
		}

    --
		-- Navigation
    --
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

    --
		-- MISC
    --

    -- Hack
    use {
      'stevearc/stickybuf.nvim',
      config = function()
        require("stickybuf").setup({
          filetype = {
            outline = "filetype",
          },
        })
      end
    }

    -- Intelligently set the root directory
		use 'airblade/vim-rooter'

		-- surround things
		use 'tpope/vim-surround'
		use 'tpope/vim-repeat'
		-- use 'tpope/vim-unimpaired'

    -- Enable editorconfig in vim
		use 'editorconfig/editorconfig-vim'

		-- Comment plugin
		use 'tomtom/tcomment_vim'
		-- Press <c-_><c-_> to comment lines
		-- Press <c-_>i for inline commenting

    use {
        "windwp/nvim-autopairs",
        config = function()
            require "plugins.autopairs"
        end
    }

		use {
			'fatih/vim-go',
			ft = 'go',
			config = function()
				require 'plugins.go-config'
			end
		}

    -- Syntax highlighting for kitty config file
    use {
      "fladson/vim-kitty",
      ft = "kitty",
    }

    -- Lua replit run :Luadev
    use {"bfredl/nvim-luadev"}

	end
)
