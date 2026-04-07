require("fzf-lua").setup({
  winopts = {
    backdrop = 0,
    fullscreen = true,
  },
})

local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader>ps",  fzf.live_grep,                   { desc = "Live grep" })
vim.keymap.set("n", "<leader>pe",  fzf.git_status,                  { desc = "Git status files" })
vim.keymap.set("n", "<leader>pb",  fzf.git_branches,                { desc = "Git branches" })
vim.keymap.set("n", "<leader>pT",  fzf.colorschemes,                { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>pd",  fzf.oldfiles,                    { desc = "Old files" })
vim.keymap.set("n", "<leader><leader>", fzf.buffers,                { desc = "Buffers" })
vim.keymap.set("n", "<leader>ph",  fzf.helptags,                    { desc = "Helptags" })
vim.keymap.set("n", "<leader>pws", fzf.grep_cword,                  { desc = "Search word under cursor" })
vim.keymap.set("n", "<leader>so",  fzf.lsp_document_symbols,        { desc = "LSP document symbols" })
vim.keymap.set("n", "<leader>po",  fzf.lsp_live_workspace_symbols,  { desc = "LSP workspace symbols" })
vim.keymap.set("n", "gr",          fzf.lsp_references,              { desc = "LSP references" })
vim.keymap.set("n", "gd",          fzf.lsp_definitions,             { desc = "LSP definitions" })
vim.keymap.set("n", "gI",          fzf.lsp_implementations,         { desc = "LSP implementations" })
