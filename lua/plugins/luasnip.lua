local ls = require("luasnip")

-- Jump forward/backward through snippet placeholders
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end,  { silent = true })
vim.keymap.set({ "i", "s" }, "<C-H>", function() ls.jump(-1) end, { silent = true })
