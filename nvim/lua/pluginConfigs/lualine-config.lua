local config = {
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { "", "" },
		section_separators = { "", "" },
		disabled_filetypes = {},
		-- globalstatus = true,
	},
	sections = {
		lualine_a = {
			{ "mode" },
		},
		lualine_b = {
			{ "branch", icon = "" },
		},
		lualine_c = {
			{ "filename", path = 1 },
		},
		lualine_x = {
			{ "filetype" },
			{ "progress" },
			{ "location" },
		},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", color = "Title", path = 1 } },
		lualine_x = { { "location", color = "Title" } },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		-- There were a bunch of bugs with this, update and try again later
		-- lualine_a = {},
		-- lualine_b = {},
		-- lualine_c = {},
		-- lualine_x = {},
		-- lualine_y = {},
		-- lualine_z = {}
	},
	extensions = {
		"fzf",
		"quickfix",
		"fugitive",
		"nvim-tree",
		"symbols-outline",
	},
}

require("lualine").setup(config)
