
require'nvim-treesitter.configs'.setup {
	-- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- I don't see a reason not to use all maintained languages
  ensure_installed = "all",
  ignore_install = {"phpdoc"},
  sync_install = false,
	highlight = { 
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true 
	},

	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
				['al'] = '@loop.outer',
				['il'] = '@loop.inner',
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',

				-- Or you can define your own textobjects like this
				-- ["iF"] = {
				--     python = "(function_definition) @function",
				--     cpp = "(function_definition) @function",
				--     c = "(function_definition) @function",
				--     java = "(method_declaration) @function",
				-- },
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']f'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']F'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[f'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[F'] = '@function.outer',
				['[]'] = '@class.outer',
			},
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
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	},
}
