-- Highlight yanked text
local yank_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Treat .mdc files as markdown
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.mdc",
  callback = function()
    vim.opt_local.filetype = "markdown"
  end,
})
