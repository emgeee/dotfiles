return {
	{
		"fatih/vim-go",
		ft = "go",
		config = function()
			-- Golang config

			-- Allow sharing the same gopls daemon with other vim instances + coc
			-- The gopls service needs to be manually started!
			vim.g.go_gopls_options = { "-remote=unix;/tmp/gopls-daemon-socket" }

			-- Disable gopls integration as it's handled by CoC
			vim.g.go_gopls_enabled = false

			-- disable vim-go :GoDef and :GoDoc shortcuts since these are better handled by CoC
			vim.g.go_def_mapping_enabled = false
			vim.g.go_doc_keywordprg_enabled = false

			-- Disable auto running go_fmt + go_imorts
			vim.g.go_fmt_autosave = false
			vim.g.go_imports_autosave = false
		end,
	},
}
