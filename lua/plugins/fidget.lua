return {
  "j-hui/fidget.nvim",
  tag = "v1.2.0",
  event = "LspAttach",
  enabled = false,
  opts = {
    progress = {
      poll_rate = 100,              -- How and when to poll for progress messages
      suppress_on_insert = true,    -- Suppress new messages while in insert mode
      ignore_done_already = false,  -- Ignore new tasks that are already complete
      ignore_empty_message = false, -- Ignore new tasks that don't contain a message
      display = {
        render_limit = 16,
        group_style = "Title", -- Highlight group for group name (LSP server name)
      },
    },
  },
}
