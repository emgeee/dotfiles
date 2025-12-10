return {
  -- Status line plugin
  {
    --- https://github.com/nvim-lualine/lualine.nvim
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { "", "" },
          section_separators = { "", "" },
          disabled_filetypes = {},
          -- globalstatus = true,
          always_divide_middle = true,
          ignore_focus = {"NvimTree"},
        },
        sections = {
          lualine_a = {
            { "mode" },
          },
          lualine_b = {
            -- { "branch", icon = "" },
          },
          lualine_c = {
            { "filename", path = 1 },
          },
          lualine_x = {
            { "diagnostics" },
            { "filetype" },
            { "progress" },
            { "location" },
          },
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { { "location" } },
          lualine_y = {},
          lualine_z = {},
        },
        -- tabline = {
        --   -- There were a bunch of bugs with this, update and try again later
        --   -- lualine_a = {},
        --   -- lualine_b = {},
        --   -- lualine_c = {},
        --   -- lualine_x = {},
        --   -- lualine_y = {},
        --   -- lualine_z = {}
        -- },
        extensions = {
          "fzf",
          "quickfix",
          "fugitive",
          "nvim-tree",
          "symbols-outline",
          "trouble",
          "toggleterm",
        },
      })
    end,
  },
}
