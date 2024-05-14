return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
          -- Get the current height of the terminal
          local line_height = vim.api.nvim_eval("&lines")
					return line_height * 0.3
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			--- Open new terminals using `2<C-\>` from the terminal window
			open_mapping = [[<c-\>]],
		},
	},
}
