
-- File Tree config
local key_mapper = require('utils.key_mapper')
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.nvim_tree_bindings = {
{ key = "?", cb = tree_cb("toggle_help") },
}
key_mapper('n', '<F3>', ':NvimTreeToggle<CR>')
key_mapper('n', '<F4>', ':NvimTreeFindFile<CR>')

-- We need to keep netrw enabled so :GBrowse will work!
vim.g.nvim_tree_disable_netrw = 0
