-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--  => General Vim tips and commands
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--  vim quick reference (cheat sheet)
--    :help quickref
--
--  Recommended keys to map custom functionality too
--    :help map-which-keys
--
--  List of commands for each mode
--    :help index
--
--  Healthcheck
--    :checkhealth
--
--  buffers
--  :bd --> deletes a buffer
--  :%bd --> deletes all open buffers
--
--  M - jump cursor to middle of display "
--
--  :ju(mp) - print jump list
--
--  brew install the_silver_searcher fzf bat fd
--
--  Tricks to decrease startup time: https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/
--
--  A well structured nvim config: https://github.com/siduck76/NvChad
--
--  Commands to run to update things
--  :PackerUpdate --> Update dependencies that are installed
--  :PackerSync --> Sync packer cache with what's defined in pluginList.lua and updates existing versions (same as PackerClean + PackerUpdate)
--  :PackerCompile --> Compiles plugines in to new cache-- Must be run!
--  :TSUpdate --> Update treesitter configs
--  :MasonToolsUpdate --> Update LSP servers
--
--  List of interesting plugins:
--  https://github.com/rockerBOO/awesome-neovim
--  https://neovimcraft.com/
--
--  Plugins to investigate
--  https://github.com/simrat39/symbols-outline.nvim
--  https://github.com/echasnovski/mini.nvim#miniindentscope
--  https://github.com/folke/which-key.nvim
--
-- To print variables
--  print(vim.inspect(x))
--

local modules = {
	"settings",
	"mappings",
	"grep",
  -- packer gets lazy loaded when needed (see the mappings.lua file)
	-- "pluginList",
}

for i = 1, #modules, 1 do
  -- pcall is safer but swallows errors
	-- pcall(require, modules[i])
	require(modules[i])
end
