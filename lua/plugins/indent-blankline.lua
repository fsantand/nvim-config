return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufEnter",
  enabled = false,
  main = "ibl",
  opts = {
    exclude = {
      filetypes = {
        "dashboard",
      },
    },
  },
}
