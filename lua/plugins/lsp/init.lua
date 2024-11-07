local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>ra", vim.lsp.buf.rename, "[R]en[a]me")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ctions")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")


  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  vim.keymap.set("i", "<C-S-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

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
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require("cmp_nvim_lsp").default_capabilities())

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true },
      },
    })

    lspconfig.denols.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    }

    lspconfig.ts_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
      typescript = {
        inlayHint = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      },
      javascript = {
        inlayHint = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      }
    }

    lspconfig.gopls.setup {
      on_attach = on_attach,
      capabilities = capabilities, }
  end,
}
