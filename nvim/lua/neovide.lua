if vim.g.neovide then
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_scroll_animation_length = 0.1

	--- https://github.com/source-foundry/Hack
	vim.o.guifont = "Hack Nerd Font:h14"
	-- vim.o.guifont = "0xProto Nerd Font Mono:h14"

	--- Configure cmd+c/cmd+v
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<D-=>", function()
		change_scale_factor(1.25)
	end, { noremap = true, silent = true, desc = "Increase font scale (Neovide)" })
	vim.keymap.set("n", "<D-->", function()
		change_scale_factor(1 / 1.25)
	end, { noremap = true, silent = true, desc = "Decrease font scale (Neovide)" })
	vim.keymap.set("n", "<D-0>", function()
		vim.g.neovide_scale_factor = 1.0
		vim.notify("Scale factor reset")
	end, { noremap = true, silent = true, desc = "Reset font scale to 1.0 (Neovide)" })

	vim.g.neovide_transparency = 1.0

	local toggle_transparency = function()
		if vim.g.neovide_transparency < 1.0 then
			vim.g.neovide_transparency = 1.0
		else
			vim.g.neovide_transparency = 0.4
		end
	end
	vim.keymap.set(
		"n",
		"<D-u>",
		toggle_transparency,
		{ noremap = true, silent = true, desc = "Toggle transparency (Neovide)" }
	)
end
