vim.g.sonokai_enable_italic = true

require("flexoki").setup({})
require("gruvbox").setup({})
require("vague").setup({})
require("dracula").setup({
  transparent_bg = true,
})

vim.cmd.colorscheme("dracula")
