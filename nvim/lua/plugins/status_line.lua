return {
  -- Status line plugin
  {
    "hoob3rt/lualine.nvim",
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
        },
        sections = {
          lualine_a = {
            { "mode" },
          },
          lualine_b = {
            { "branch", icon = "" },
          },
          lualine_c = {
            { "filename", path = 1 },
          },
          lualine_x = {
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
        tabline = {
          -- There were a bunch of bugs with this, update and try again later
          -- lualine_a = {},
          -- lualine_b = {},
          -- lualine_c = {},
          -- lualine_x = {},
          -- lualine_y = {},
          -- lualine_z = {}
        },
        extensions = {
          "fzf",
          "quickfix",
          "fugitive",
          "nvim-tree",
          "symbols-outline",
          "trouble",
        },
      })
    end,
  },
}
