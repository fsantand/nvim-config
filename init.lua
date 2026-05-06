require("config.options")
require("config.keymaps")
require("config.autocmds")
require("vim._core.ui2").enable({
  enable=true
})

-- Install and load all plugins via the built-in vim.pack (nvim 0.12+)
vim.pack.add({
  -- Shared dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/rafamadriz/friendly-snippets",

  -- Colorschemes
  "https://github.com/sainnhe/sonokai",
  "https://github.com/olimorris/onedarkpro.nvim",
  "https://github.com/MartelleV/kaimandres.nvim",
  "https://github.com/kepano/flexoki-neovim",
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/vague-theme/vague.nvim",
  "https://github.com/Mofiqul/dracula.nvim",


  -- UI
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/levouh/tint.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/todo-comments.nvim",
  {
    src = "https://github.com/Saghen/blink.cmp",
    version = "v1",
  },
  "https://github.com/Bekaboo/dropbar.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",

  -- File navigation
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/kevinhwang91/nvim-bqf",
  "https://github.com/dmtrKovalenko/fff.nvim",

  -- LSP
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/folke/neoconf.nvim",
  "https://github.com/folke/lazydev.nvim",

  -- Snippets
  "https://github.com/L3MON4D3/LuaSnip",

  -- Treesitter (main branch — required for nvim 0.12)
  "https://github.com/nvim-treesitter/nvim-treesitter",

  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/vincent178/nvim-github-linker",

  -- Editing
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/m4xshen/hardtime.nvim",
  "https://github.com/folke/zen-mode.nvim",
  "https://github.com/kkoomen/vim-doge",

  -- Formatting / Linting
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",

  -- Debug
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
  "https://github.com/leoluz/nvim-dap-go",

  -- DB
  "https://github.com/kndndrj/nvim-dbee",

  -- Copilot
  "https://github.com/fang2hou/blink-copilot",
})

-- Simple setups (no dedicated config file needed)
require("mason").setup()
require("neoconf").setup()
require("mini.icons").setup()
require("bqf").setup()
require("render-markdown").setup({})

-- Plugin configs (order matters: lazydev before lsp)
require("plugins.colorscheme")
require("plugins.lazydev")
require("plugins.lsp")
require("plugins.blink")
require("plugins.treesitter")
require("plugins.ui")
require("plugins.oil")
require("plugins.fzf")
require("plugins.gitsigns")
require("plugins.git")
require("plugins.luasnip")
require("plugins.conform")
require("plugins.nvim-lint")
require("plugins.nvim-dap")
require("plugins.fff")
require("plugins.db")
require("plugins.dropbar")
