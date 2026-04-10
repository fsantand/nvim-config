vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up half page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down half page" })
vim.keymap.set("n", "<leader>rn", ":set relativenumber!<CR>", { silent = true, desc = "Toggle relative number" })
vim.keymap.set("n", "<leader>mp", "<cmd>!inlyne % &<cr>", { desc = "Preview markdown" })
vim.keymap.set("n", "<leader>zm", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer local keymaps (which-key)" })

-- Diagnostics
vim.keymap.set("n", "<leader>vd", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Open diagnostic float" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ border = "rounded", count = 1, float = true })
end, { desc = "Diagnostics: Go to next" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ border = "rounded", count = -1, float = true })
end, { desc = "Diagnostics: Go to previous" })

-- lsp
local function toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local function toggle_codelens()
  vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
end

vim.keymap.set("n", "gD", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, { desc = "LSP: Rename" })
vim.keymap.set("n", "<leader>th", toggle_inlay_hints, { desc = "LSP: Accept inline completion" })
vim.keymap.set("n", "<leader>tcl", toggle_codelens, { desc = "LSP: Accept inline completion" })
vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "LSP: Show signature" })
vim.keymap.set("i", "<C-l><C-y>", vim.lsp.inline_completion.get, { desc = "LSP: Accept inline completion" })
vim.keymap.set("i", "<C-l><C-n>", vim.lsp.inline_completion.select, { desc = "LSP: Accept inline completion" })
