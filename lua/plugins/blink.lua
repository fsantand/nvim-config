require("blink.cmp").setup({
  signature = {
    enabled = true,
  },
  completion = {
    keyword = {
      range = "full"
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = true,
    }
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "copilot" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        async = true,
      }
    }
  }
})
