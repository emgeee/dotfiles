local config = {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {{'filename', color="WarningMsg", path=1}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', color="Title", path=1}},
    lualine_x = {{'location', color="Title"}},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fzf', 'quickfix', 'fugitive'}
}

--  require('utils.get-function-name')

-- The following functions are pulled from https://gist.github.com/hoob3rt/b200435a765ca18f09f83580a606b878
-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- WIP
-- ins_right {
--   function() return require('nvim-treesitter').statusline({indicator_size=20}) end
-- }

ins_right {
  'filetype'
}
ins_right {
  'progress'
}
ins_right {
  'location'
}


require('lualine').setup(config)
