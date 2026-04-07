require("oil").setup({
  default_file_explorer = true,
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open oil file explorer" })
