return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
  },
  lazy = false,
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    {"-", "<cmd>Oil<cr>", desc = "Toggle Oil"}
  }
}
