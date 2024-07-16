return {
	-- UI to select things (files, grep results, open buffers...)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "danielfalk/smart-open.nvim", branch = "0.2.x", dependencies = { "kkharji/sqlite.lua" } },
			-- { "jonarrien/telescope-cmdline.nvim" },
			{ "junegunn/fzf" },
		},
		config = function()
			-- Telescope
			-- https://github.com/nvim-telescope/telescope.nvim
			local present, telescope = pcall(require, "telescope")

			if not present then
				print("Error loading telescope")
				return
			end

			local actions = require("telescope.actions")

			-- local action_state = require("telescope.actions.state")
			-- local state = require("telescope.state")

			-- local slow_scroll = function(prompt_bufnr, direction)
			-- 	local previewer = action_state.get_current_picker(prompt_bufnr).previewer
			-- 	local status = state.get_status(prompt_bufnr)
			--
			-- 	-- Check if we actually have a previewer and a preview window
			-- 	if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
			-- 		return
			-- 	end
			--
			-- 	previewer:scroll_fn(1 * direction)
			-- end

			--- https://github.com/nvim-telescope/telescope.nvim
			telescope.setup({
				defaults = {
					-- Note: <C-c> is the most efficient way to close the window
					mappings = {
						i = {
							["<C-f>"] = false,

							["<esc>"] = actions.close,
							-- ["<C-u>"] = false,
							["<C-u>"] = actions.results_scrolling_up,
							["<C-d>"] = actions.results_scrolling_down,

							-- ["<C-h>"] = actions.preview_scrolling_left,
							["<C-j>"] = actions.preview_scrolling_down,
							["<C-k>"] = actions.preview_scrolling_up,
							-- ["<C-l>"] = actions.preview_scrolling_right,
						},
					},
					generic_sorter = require("telescope.sorters").get_fzy_sorter,
					file_sorter = require("telescope.sorters").get_fzy_sorter,
					prompt_prefix = "   ",
					selection_caret = " ",
				},
				pickers = {
					find_files = {
						theme = "ivy",
					},
					grep_string = {
						theme = "ivy",
					},
					live_grep = {
						theme = "ivy",
					},
					buffers = {
						theme = "ivy",
						mappings = {
							i = {
								["<C-d>"] = actions.delete_buffer,
							},
							n = {
								["<C-d>"] = actions.delete_buffer,
							},
						},
					},
				},
        extensions = {
					smart_open = {
						theme = "ivy",
					},
        },
			})

			telescope.load_extension("fzy_native")
			telescope.load_extension("media_files")
			telescope.load_extension("smart_open")
			-- telescope.load_extension("cmdline")

			-- small local function for shorter line length
			local bi = function()
				return require("telescope.builtin")
			end

			--Add leader shortcuts
			vim.keymap.set("n", "<C-p>", function()
				bi().find_files()
			end, { desc = "Find files (Telescope)" })

			vim.keymap.set("n", "<leader><leader>", function()
				-- require("telescope").extensions.smart_open.smart_open({theme = "ivy"})

				bi().buffers({
					sort_mru = true,
					-- ignore_current_buffer = true,
					-- show_all_buffers = false,
				})
			end, { desc = "show buffers (Telescope)" })

			vim.keymap.set("n", "<leader>?", function()
				bi().oldfiles()
			end, { desc = "show old files (Telescope)" })

			vim.keymap.set("n", "<leader>sg", function()
				bi().live_grep()
			end, { desc = "live grep (Telescope)" })

			vim.keymap.set("n", "<leader>sw", function()
				local word = vim.api.nvim_eval('expand("<cword>")')
				bi().grep_string({ word_match = "-w", default_text = word })
			end, { desc = "search word under cursor (Telescope)" })

			vim.keymap.set("n", "<leader>ss", function()
				require("session-lens").search_session()
			end, { desc = "show sessions (session-lens) (Telescope)" })

			vim.keymap.set("n", "<leader>gc", function()
				bi().git_commits()
			end, { desc = "show git commits (Telescope)" })

			-- vim.keymap.set('n', '<leader>gb', function() bi().git_branches() end, {desc = "show git branches (Telescope)"})
			vim.keymap.set("n", "<leader>gs", function()
				bi().git_status()
			end, { desc = "show git status (Telescope)" })

			vim.keymap.set("n", "<leader>gp", function()
				bi().git_bcommits()
			end, { desc = "show buffer's git commits  (Telescope)" })

			vim.keymap.set("n", "<leader>gkm", function()
				bi().keymaps()
			end, { desc = "Show keymaps/hotkeys (Telescope)" })

			vim.api.nvim_create_user_command("Hotkeys", function()
				bi().keymaps()
			end, { desc = "Show hotkeys" })
			-- vim.api.nvim_set_keymap('n', ':', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })

			-- Search for text
			vim.api.nvim_create_user_command("Search", function(opts)
				bi().live_grep({ default_text = opts.args })
			end, { nargs = "*" })
			vim.cmd([[cnoreabbrev ack Search]])
			vim.cmd([[cnoreabbrev Ack Search]])
			vim.cmd([[cnoreabbrev ss Search]]) -- Search string
		end,
	},
}
