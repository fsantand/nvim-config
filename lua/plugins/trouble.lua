return {
  "folke/trouble.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  event = "LspAttach",
  opts = {},
  config = function ()
    vim.keymap.set("n", "<leader>qd", ":TroubleToggle workspace_diagnostics<CR>", { desc = "Diagnostics: Open QF" })
    vim.keymap.set("n", "<leader>qa", ":TroubleToggle document_diagnostics<CR>", { desc = "Diagnostics: Open QF" })
  end
}
