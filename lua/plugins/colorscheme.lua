vim.g.sonokai_enable_italic = true

require("kaimandres").setup({})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "kaimandres",
  callback = function()
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#16161e" })
  end,
})

vim.cmd.colorscheme("kaimandres")
