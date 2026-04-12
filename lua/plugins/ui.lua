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
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = { "location" },
    lualine_z = { "branch" },
  },
  inactive_sections = {
    lualine_c = {},
    lualine_x = {},
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
