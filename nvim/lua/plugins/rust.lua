return {
	-- Rust stuff
	-- {
	--   'mrcjkb/rustaceanvim',
	--   version = '^4', -- Recommended
	--   lazy = false, -- This plugin is already lazy
	-- },

	{
		"vxpm/ferris.nvim",
		opts = {
			create_commands = true,
		},
	},
	-- Work with crates inside Cargo.toml files
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup({
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
			})
		end,
	},
}
