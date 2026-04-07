-- nvim-treesitter main branch (required for nvim 0.12).
-- The old configs API (require('nvim-treesitter.configs').setup) is gone.
-- Highlighting is now done via Neovim's built-in vim.treesitter.start().
-- NOTE: Requires the tree-sitter CLI: brew install tree-sitter

local parsers = {
  "bash", "c", "cpp", "go", "javascript", "jsdoc",
  "lua", "python", "query", "tsx", "typescript",
  "vim", "vimdoc",
}

-- Install parsers that aren't present yet (idempotent)
local ok, ts = pcall(require, "nvim-treesitter")
if ok then
  ts.install(parsers)
end

-- Enable treesitter highlighting for every filetype that has a parser
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Map custom filetypes to existing parsers
vim.treesitter.language.register("markdown", { "octo", "mdc" })
