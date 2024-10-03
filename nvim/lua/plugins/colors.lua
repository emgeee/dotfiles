--
-- UI pluginConfigs
--
-- change color scheme with
-- :colorscheme <name>
--
return {
  {
    --- https://github.com/folke/tokyonight.nvim
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
      })
      -- if vim.g.neovide then
      vim.cmd("colorscheme tokyonight-storm")
      -- end
    end,
  },
  {
    --- https://github.com/navarasu/onedark.nvim
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.onedark_terminal_italics = 2

      require("onedark").setup({
        style = "deep",
      })
      -- require("onedark").load()
    end,
  },
  {
    --- https://github.com/bluz71/vim-nightfly-colors
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nightflyCursorColor = true
      vim.g.nightflyNormalFloat = false

      -- vim.cmd("colorscheme nightfly")
    end,
  },
  {
    --- https://github.com/bluz71/vim-moonfly-colors
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },
  {
    --- https://github.com/nyoom-engineering/oxocarbon.nvim
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    --- https://github.com/scottmckendry/cyberdream.nvim
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      })
    end,
  },
  {
    --- https://github.com/catppuccin/nvim
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          cmp = true,
          fidget = true,
          indent_blankline = { enabled = true },
          lsp_saga = true,
          mason = true,
          lsp_trouble = true,
          telescope = true,
        },
      })

      -- if not vim.g.neovide then
      --   vim.cmd("colorscheme catppuccin-mocha")
      -- end
    end,
  },
  {
    --- https://github.com/diegoulloao/neofusion.nvim
    "diegoulloao/neofusion.nvim",
    priority = 1000,
    config = true,
  },
}
