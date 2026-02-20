return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      backdrop = 0,
      fullscreen = true,
    }
  },
  keys = {
    {"<leader>ps", "<cmd>:FzfLua live_grep<cr>", desc = "Live grep"},
    {"<leader>pe", "<cmd>:FzfLua git_status<cr>", desc = "Git Status Files"},
    {"<leader>pb", "<cmd>:FzfLua git_branches<cr>", desc = "Git Status Files"},
    {"<leader>pT", "<cmd>:FzfLua colorschemes<cr>", desc = "Colorschemes"},
    {"<leader>pd", "<cmd>:FzfLua oldfiles<cr>", desc = "Old files"},
    {"<leader><leader>", "<cmd>:FzfLua buffers<cr>", desc = "Buffers"},
    {"<leader>ph", "<cmd>:FzfLua helptags<cr>", desc = "Helptags"},
    {"<leader>pws","<cmd>:FzfLua grep_cword<CR>", desc = "Search selected word"},
    {"<leader>so","<cmd>:FzfLua lsp_document_symbols<CR>", desc = "Find LSP document symbols"},
    {"<leader>po","<cmd>:FzfLua lsp_live_workspace_symbols<CR>", desc = "Find LSP Workspace symbols"},
    {"gr","<cmd>:FzfLua lsp_references<CR>", desc = "Get references"},
    {"gd","<cmd>:FzfLua lsp_definitions<CR>", desc = "Get definitions"},
    {"gI","<cmd>:FzfLua lsp_implementations<CR>", desc = "Get implementations"},
  }
}
