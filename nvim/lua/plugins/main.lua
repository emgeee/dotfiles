-- if `opts` is specified, it is passed to the `require(<plugin>).setup(opts)` automatically
-- if `config` function is set, `opts` is passed as the second param so you must call setup() manually
-- Ex:
-- config = function(_, opts)
--     ...
-- end

return {
	{ "nvim-lua/plenary.nvim" },
	{
		"folke/neodev.nvim",
		opts = {
			library = { plugins = { "neotest" }, types = true },
		},
	},

	-- Git commands in nvim
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	{
		"jdhao/better-escape.vim",
		event = "InsertEnter",
		config = function()
			vim.g.better_escape_interval = 300
			vim.g.better_escape_shortcut = { "jk" }
		end,
	},

	-- better quickfix window
	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	-- Mason config
	-- Mason is a tool for managing and installing LSP clients, linters, formatters etc
	-- Installs clients to directory :lua print(vim.fn.stdpath("data"))
	-- Full list of language servers: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
	{
		"williamboman/mason.nvim",
		config = true,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"williamboman/mason-lspconfig.nvim",
			"RRethy/vim-illuminate", -- illuminate works under the cursor
			"scalameta/nvim-metals", -- Scala metals integration
			"hrsh7th/nvim-cmp", -- Specify completion engine
		},
		config = function()
			require("pluginConfigs.lspconfig")
		end,
	},

	-- Works by combining inputs from different sources to generate autocomplete

	-- Support for linters
	-- none-ls is fork of null-ls (which was deprecated). They didn't change the name
	-- of the package though so everything is imported as 'null-ls'.
	-- This package provides a way to hook in various formatters, linters etc into
	-- neovim's LSP system. This is only needed for plugins/tools that aren't themselves
	-- an lsp server
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("pluginConfigs.null-ls-config")
		end,
	},

	-- Open diagnostic pane with :Trouble
	{
		"folke/trouble.nvim",
		branch = "dev", -- IMPORTANT!
		cmd = "Trouble",
		keys = {
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Project Diagnostics (Trouble)",
			},
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	},

	-- {
	-- 	--- https://github.com/dgagn/diagflow.nvim
	-- 	"dgagn/diagflow.nvim",
	-- 	-- event = 'LspAttach', This is what I use personnally and it works great
	-- 	opts = {},
	-- },

	-- mostly used for a pretty LSP hover functionality
	-- hotkeys specified in lspconfig.lua
	-- Note: the plugin seems really powerful
	{
		-- "nvimdev/lspsaga.nvim",
		"emgeee/lspsaga.nvim",
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
			})
			require("lspsaga").setup({
				lightbulb = {
					-- enable = false,
					sign = false,
				},
				-- Currently using dropbar plugin stead
				-- symbol_in_winbar = {
				-- 	enable = false,
				-- },
				implement = {
					enable = false,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- vim.notify backend
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				override_vim_notify = true,
			},
			logger = {
				level = vim.log.levels.INFO,
			},
		},
	},

	-- :SymbolsOutline to open window
	-- Lspsaga can also do this - :Lspsaga outline .
	-- Trouble can also do this - :Trouble symbols
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				keymaps = {
					close = { "q" }, -- Keep pressing esc by accident so unbind it
				},
			})

			vim.api.nvim_create_user_command("Outline", "SymbolsOutline", {})
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { noremap = true })
		end,
	},

	-- Add indentation guides even on blank lines
	{
		--- https://github.com/lukas-reineke/indent-blankline.nvim
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		event = "BufRead",
		config = function()
			require("ibl").setup({
				indent = { char = "┊" },
				exclude = {
					filetypes = { "help", "terminal", "dashboard", "lazy" },
					buftypes = { "terminal", "nofile" },
				},
				scope = { show_start = true },
			})
		end,
	},

	-- Add git related info in the signs columns and popups
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = true,
	},

	--
	-- MISC
	--

	-- Hack
	{
		"stevearc/stickybuf.nvim",
		opts = {},
	},

	-- Intelligently set the root directory
	"airblade/vim-rooter",

	-- surround things
	"tpope/vim-surround",
	"tpope/vim-repeat",

	-- Enable editorconfig in vim
	"editorconfig/editorconfig-vim",

	-- Comment plugin
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring", -- Required for ts/tsx support
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					line = "<C-_><C-_>",
					block = "<C-_>i",
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					line = "<C-_><C-_>",
					block = "<C-_>i",
				},
			})
		end,
		opts = {},
		lazy = false,
	},

	{
		--- https://github.com/windwp/nvim-autopairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	},

	-- Syntax highlighting for kitty config file
	{
		"fladson/vim-kitty",
		ft = "kitty",
	},

	-- Lua replit run :Luadev
	{ "bfredl/nvim-luadev", cmd = "Luadev" },

	-- Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rouge8/neotest-rust",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-rust"),
				},
			})
		end,
	},
}
