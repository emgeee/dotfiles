---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	-- one of "all", "maintained" (parsers with maintainers), or a list of languages
	-- I don't see a reason not to use all maintained languages
	ensure_installed = "all",
	auto_install = true,
	ignore_install = { "phpdoc" },
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = function(lang, bufnr)
			-- These features are slow as hell on large files so disable them
			return vim.api.nvim_buf_line_count(bufnr) > 1000
		end,
	},
	indent = {
		enable = true,
		disable = function(lang, bufnr)
			-- indent module doesn't work well for rust
			return vim.api.nvim_buf_line_count(bufnr) > 1000 or lang == "python" or lang == "rust"
		end,
	},

	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				-- NOTE: for HTML/JSX ust 'at' and 'it' (t = tag)
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},

	textsubjects = {
		enable = true,
		prev_selection = ",", -- (Optional) keymap to select the previous selection
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
			["i;"] = { "textsubjects-container-inner", desc = "Select inside containers (classes, functions, etc.)" },
		},
	},

	-- activate with :TSPlaygroundToggle
	-- could be fun to play with
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})
