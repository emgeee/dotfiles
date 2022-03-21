-- File Tree config
local key_mapper = require('utils.key_mapper')
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

local list = {
  { key = "?", cb = tree_cb("toggle_help") },
}

require('nvim-tree').setup({
  auto_close = true,
  -- open_on_setup = true,
  disable_netrw = false,
  view = {
    mappings = {
      list = list
    }
  }
})
key_mapper('n', '<F3>', ':NvimTreeToggle<CR>')
key_mapper('n', '<F4>', ':NvimTreeFindFile<CR>')
