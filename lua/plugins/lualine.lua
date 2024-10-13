return {
  'nvim-lualine/lualine.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = "nightfox",
    },
    extensions = {
      "oil",
      "mason",
      "fugitive",
      "nvim-dap-ui",
      "quickfix",
      "trouble",
    }
  },
}
