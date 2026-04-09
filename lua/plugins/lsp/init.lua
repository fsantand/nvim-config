vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

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

vim.lsp.inline_completion.enable()

vim.lsp.config('*', {
  root_markers = { '.git' },
})

-- Lua
vim.lsp.config('lua_ls', {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },
  -- Filetypes to automatically attach to.
  filetypes = { 'lua' },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      codelens = {
        enable = true,
        run = true,
      },
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
})

vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  root_markers = {
    "pyproject.toml", "setup.py", "setup.cfg",
    "requirements.txt", "Pipfile", "pyrightconfig.json", ".git",
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        autoImportCompletions = true,
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = true,
        },
      },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "basedpyright",
  "copilot",
})
