local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>ra", vim.lsp.buf.rename, "[R]en[a]me")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ctions")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    nmap('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr })
    end, '[T]oggle Inlay [H]ints')
  end
end

return {
  "neovim/nvim-lspconfig",
  dependencies = { -- Automatically install LSPs to stdpath for neovim
    { "williamboman/mason.nvim", opts={}, lazy=false },
    { "saghen/blink.cmp"},
  },
  opts = {
    inlay_hints = { enabled = true },
  },
  config = function(_, opts)
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    vim.lsp.config("lua_ls",{
      on_attach = on_attach,
      capabilities = capabilities,
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true },
      },
    })

    vim.lsp.config("basedpyright", {
      on_attach = on_attach,
      cmd = { "basedpyright-langserver", "--stdio" },
      root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
      },
      capabilities = capabilities,
      inlay_hints = { enabled = true },
      settings = {
        basedpyright = {
          analysis = {
            autoSearcchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
            inlayHints = {
              variableTypes = true,
              callArgumentNames = true,
              functionReturnTypes = true,
              genericTypes = true,
            },
          }
        }
      }
    })

    vim.lsp.config("ruff", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "off",
          }
        }
      }
    })

    vim.lsp.enable({
      "luals",
      "basedpyright",
      "ruff",
    })
  end,
}
