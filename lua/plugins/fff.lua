-- NOTE: fff.nvim requires a pre-built binary. With vim.pack the build step is
-- not run automatically. Run it manually once:
--   :lua require('fff.download').download_or_build_binary()
local fff = require("fff")

vim.keymap.set("n", "<leader>pf", function() fff.find_in_git_root() end, { desc = "FFF: Find git files" })
vim.keymap.set("n", "<leader>pa", function() fff.find_files() end,         { desc = "FFF: Find all files" })
vim.keymap.set("n", "<leader>pcf", function()
  fff.find_files_in_dir("~/.config/nvim/")
end, { desc = "FFF: Find nvim config files" })
