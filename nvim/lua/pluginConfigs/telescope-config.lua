-- Telescope
-- https://github.com/nvim-telescope/telescope.nvim
local present, telescope = pcall(require, "telescope")

if not present then
  print("Error loading telescope")
  return
end

telescope.setup {
  defaults = {
    -- Note: <C-c> is the most efficient way to close the window
    mappings = {
      i = {
        -- ["<C-u>"] = false,
        -- ["<C-d>"] = require('telescope.actions').delete_buffer,
        ["<C-d>"] = require('telescope.actions').results_scrolling_down,
        ["<C-u>"] = require('telescope.actions').results_scrolling_up,

        ["<C-h>"] = require('telescope.actions').preview_scrolling_left,
        ["<C-j>"] = require('telescope.actions').preview_scrolling_down,
        ["<C-k>"] = require('telescope.actions').preview_scrolling_up,
        ["<C-l>"] = require('telescope.actions').preview_scrolling_right,
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
vim.keymap.set('n', '<C-p>', function() bi().find_files() end, {desc = "Find files (Telescope)"})
vim.keymap.set('n', '<leader><space>', function() bi().buffers() end, {desc = "show buffers (Telescope)"})
vim.keymap.set('n', '<leader>?', function() bi().oldfiles() end, {desc = "show old files (Telescope)"})
vim.keymap.set('n', '<leader>sg', function() bi().live_grep() end, {desc = "live grep (Telescope)"})
vim.keymap.set('n', '<leader>sw', function() bi().grep_string({word_match = "-w"}) end, {desc = "search word (Telescope)"})
vim.keymap.set('n', '<leader>ss', function() require('session-lens').search_session() end, {desc = "show sessions (session-lens) (Telescope)"})

vim.keymap.set('n', '<leader>gc', function() bi().git_commits() end, {desc = "show git commits (Telescope)"})
-- vim.keymap.set('n', '<leader>gb', function() bi().git_branches() end, {desc = "show git branches (Telescope)"})
vim.keymap.set('n', '<leader>gs', function() bi().git_status() end, {desc = "show git status (Telescope)"})
vim.keymap.set('n', '<leader>gp', function() bi().git_bcommits() end, {desc = "show buffer's git commits  (Telescope)"})
vim.keymap.set('n', '<leader>gkm', function() bi().keymaps() end, {desc = "Show keymaps (Telescope)"})
