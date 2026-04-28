local dbee = require("dbee")

vim.keymap.set("n", "<leader>db", dbee.toggle, { desc = "DB: Open Dbee" })

dbee.setup()
