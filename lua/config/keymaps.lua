vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up half page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down half page" })
vim.keymap.set("n", "<leader>rn", ":set relativenumber!<CR>", { silent = true, desc = "Toggle relative number" })
vim.keymap.set("n", "<leader>mp", "<cmd>!go-grip %<cr>", { desc = "Preview markdown" })
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

-- Copy a file reference for Claude Code (:ClaudeCopyRef, :'<,'>ClaudeCopyRef, :ClaudeCopyRef! for absolute path)
vim.api.nvim_create_user_command("ClaudeCopyRef", function(opts)
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Buffer has no file name", vim.log.levels.WARN)
    return
  end
  if not opts.bang then
    local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
    path = vim.fs.relpath(root, path) or path
  end
  local ref = path
  if opts.range == 2 then
    ref = opts.line1 == opts.line2 and ("%s:%d"):format(path, opts.line1)
      or ("%s:%d-%d"):format(path, opts.line1, opts.line2)
  end
  vim.fn.setreg("+", ref)
  vim.notify("Copied: " .. ref)
end, { range = true, bang = true, desc = "Copy file reference (bang = absolute path)" })

vim.keymap.set({ "n", "x" }, "<leader>cr", ":ClaudeCopyRef<CR>", { desc = "Copy file reference for Claude" })
