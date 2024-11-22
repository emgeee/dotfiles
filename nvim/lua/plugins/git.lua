return {
	-- Git commands in nvim
	{
		"tpope/vim-fugitive",
		config = function()
			-- vim fugitive shortcuts
			-- vim.keymap.set("n", "<leader>gs", ":Git<CR>", { noremap = true, silent = true, desc = "" })
			-- vim.keymap.set("n", "<leader>gd", ":Gdiff<CR>", { noremap = true, silent = true, desc = "" })
			vim.cmd([[cnoreabbrev gb GBrowse]])
			vim.cmd([[cnoreabbrev Gb GBrowse]])
			vim.cmd([[cnoreabbrev Gbrowse GBrowse]])
		end,
	},
	{ "tpope/vim-rhubarb" },

	-- Add git related info in the signs columns and popups
	{
		--- https://github.com/lewis6991/gitsigns.nvim
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = true,
	},
}
