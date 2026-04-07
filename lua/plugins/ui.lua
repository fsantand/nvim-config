-- lualine
require("lualine").setup({
  options = {
    icons_enabled = true,
    section_separators = "",
    component_separators = "",
  },
  extensions = { "oil", "mason", "fugitive", "nvim-dap-ui", "quickfix" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "diff", "diagnostics" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "location" },
    lualine_z = { "branch" },
  },
  inactive_sections = {
    lualine_c = {},
    lualine_x = {},
  },
  winbar = {
    lualine_a = { "filename" },
    lualine_b = { "" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = { "filename" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})

-- tint (dim inactive windows)
require("tint").setup({ tint = -40 })

-- which-key
require("which-key").setup()

-- todo-comments
require("todo-comments").setup()

-- hardtime (bad habit training)
require("hardtime").setup()
