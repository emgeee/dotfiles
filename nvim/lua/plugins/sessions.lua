--
-- Session management
--
return {
	{
    --- https://github.com/rmagatti/auto-session
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
	{
		--- :SearchSession - fuzzy find sessions with telescope
		"rmagatti/session-lens",
		dependencies = { "rmagatti/auto-session" },
		config = true,
	},
}
