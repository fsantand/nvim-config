-- LSP keymaps and native completion set on every attach
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  nmap("<leader>ra", vim.lsp.buf.rename,      "[R]en[a]me")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ctions")
  nmap("K",          vim.lsp.buf.hover,       "Hover Documentation")
  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature help" })

  -- Native nvim 0.12 auto-completion
  if client:supports_method("textDocument/completion") then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    nmap("<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end, "[T]oggle Inlay [H]ints")
  end
end

-- Lua
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },
})

-- Python
vim.lsp.config("basedpyright", {
  on_attach = on_attach,
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

-- Python linter/formatter via ruff
vim.lsp.config("ruff", {
  on_attach = on_attach,
})

vim.lsp.enable({
  "lua_ls",
  "basedpyright",
  "ruff",
})
