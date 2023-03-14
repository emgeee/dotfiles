-- Telescope
local present, telescope = pcall(require, "telescope")

if not present then
  print("Error loading telescope")
  return
end

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = require('telescope.actions').delete_buffer,
      },
    },
    generic_sorter = require 'telescope.sorters'.get_fzy_sorter,
    file_sorter = require 'telescope.sorters'.get_fzy_sorter,
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    grep_string = {
      theme = "ivy",
    },
  },
}

telescope.load_extension('fzy_native')
telescope.load_extension("media_files")

-- small local function for shorter line length
local bi = function ()
  return require('telescope.builtin')
end

--Add leader shortcuts
vim.keymap.set('n', '<C-p>', function() bi().find_files() end)
vim.keymap.set('n', '<leader><space>', function() bi().buffers() end)
vim.keymap.set('n', '<leader>?', function() bi().oldfiles() end)
vim.keymap.set('n', '<leader>sg', function() bi().live_grep() end)
vim.keymap.set('n', '<leader>sw', function() bi().grep_string({word_match = "-w"}) end)
vim.keymap.set('n', '<leader>ss', function() require('session-lens').search_session() end)

vim.keymap.set('n', '<leader>gc', function() bi().git_commits() end)
-- vim.keymap.set('n', '<leader>gb', function() bi().git_branches() end)
vim.keymap.set('n', '<leader>gs', function() bi().git_status() end)
vim.keymap.set('n', '<leader>gp', function() bi().git_bcommits() end)
