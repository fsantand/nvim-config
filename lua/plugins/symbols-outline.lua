return {
  'simrat39/symbols-outline.nvim',
  opts = {
    autofold_depth = 1,
  },
  event = "LspAttach",
  keys = {
    {"<leader>so", "<cmd>SymbolsOutline<cr>", desc="Toggle SymbolsOutline" },
  }
}
