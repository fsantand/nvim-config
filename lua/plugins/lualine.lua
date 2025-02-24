return {
  'nvim-lualine/lualine.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = "gruvbox-material",
      section_separators = '',
      component_separators = '',
    },
    extensions = {
      "oil",
      "mason",
      "fugitive",
      "nvim-dap-ui",
      "quickfix",
      "trouble",
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'diff', 'diagnostics'},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {'location'},
      lualine_z = {'branch'},
    },
    inactive_sections = {
      lualine_c = {},
      lualine_x = {},
    },
    winbar = {
      lualine_a = {'filename'},
      lualine_b = {''},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {'filename'},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}
