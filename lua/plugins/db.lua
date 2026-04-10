-- require("db").setup({
--   opts = {
--     connections = {
--       {
--         name = "toku-local",
--         host = "localhost",
--         port = "5432",
--         user = "postgres",
--         password = "postgres",
--       },
--       {
--         name = "toku-prod",
--         host = "localhost",
--         port = "3321",
--         user = "federico_santander",
--         password = "~a<c{Mqi7bqfEZms",
--       },
--       {
--         name = "toku-dev",
--         host = "localhost",
--         port = "3301",
--         user = "federico_santander",
--         password = "(He%t<9v0pY0L2st",
--       },
--     }
--   }
-- })
local dbee = require("dbee")

vim.keymap.set("n", "<leader>db", dbee.toggle, { desc = "DB: Open Dbee" })

dbee.setup()
