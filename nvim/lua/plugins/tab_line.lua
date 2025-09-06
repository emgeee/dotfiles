return {
	--- https://github.com/romgrk/barbar.nvim
	-- {
	--   "romgrk/barbar.nvim",
	--   enabled = false,
	--   version = "^1..0",
	--   dependencies = {
	--     "lewis6991/gitsigns.nvim",  -- OPTIONAL: for git status
	--     "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	--   },
	--   init = function()
	--     vim.g.barbar_auto_setup = false
	--   end,
	--   opts = {},
	-- },

	{
		--- https://github.com/akinsho/bufferline.nvim
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
    after = "catppuccin",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "tabs",
					separator_style = "slant",
					indicator = {
						style = "underline",
					},
					show_tab_indicators = true,
					show_duplicate_prefix = false,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true, -- use a "true" to enable the default, or set your own character
						},
					},
					highlights = require("catppuccin.groups.integrations.bufferline").get_theme(),
				},
			})

			vim.keymap.set(
				"n",
				"gb",
				":BufferLinePick<CR>",
				{ noremap = true, silent = true, desc = "Select buffer" }
			)
			-- vim.keymap.set(
			-- 	"n",
			-- 	"gB",
			-- 	":BufferLineCyclePrev<CR>",
			-- 	{ noremap = true, silent = true, desc = "Previous buffer" }
			-- )

			vim.keymap.set(
				"n",
				"]b",
				":BufferLineCycleNext<CR>",
				{ noremap = true, silent = true, desc = "Next buffer" }
			)
			vim.keymap.set(
				"n",
				"[b",
				":BufferLineCyclePrev<CR>",
				{ noremap = true, silent = true, desc = "Previous buffer" }
			)
		end,
	},
}
