return {
  --- https://github.com/romgrk/barbar.nvim
  -- {
  --   "romgrk/barbar.nvim",
  --   enabled = false,
  --   version = "^1..0",
  --   dependencies = {
  --     "lewis6991/gitsigns.nvim",  -- OPTIONAL: for git status
  --     "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  --   },
  --   init = function()
  --     vim.g.barbar_auto_setup = false
  --   end,
  --   opts = {},
  -- },

  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      require("bufferline").setup({
        options = {
          mode = "tabs",
          style_preset = bufferline.style_preset.minimal,
          separator_style = "slant",
          indicator = {
            style = "underline",
          },
          show_duplicate_prefix = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true, -- use a "true" to enable the default, or set your own character
            },
          },
        },
      })
    end,
  },
}
