vim.g.rustaceanvim = {
  server = {
    capabilities = require("blink.cmp").get_lsp_capabilities({
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }, true),
    default_settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
          features = "all",
        },
        procMacro = {
          enable = true,
          attributes = {
            enable = true,
          },
        },
        completion = {
          autoimport = {
            enable = true,
          },
          postfix = {
            enable = true,
          },
        },
        checkOnSave = true,
        check = {
          command = "clippy",
        },
        inlayHints = {
          bindingModeHints = { enable = true },
          closureReturnTypeHints = { enable = "always" },
          lifetimeElisionHints = { enable = "skip_trivial" },
          parameterHints = { enable = true },
          typeHints = { enable = true },
        },
      },
    },
  },
  tools = {
    hover_actions = {
      replace_builtin_hover = true,
    },
  },
  dap = {
    autoload_configurations = true,
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function(ev)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    map("<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Rust: Runnables")
    map("<leader>rd", function() vim.cmd.RustLsp("debuggables") end, "Rust: Debuggables")
    map("<leader>rt", function() vim.cmd.RustLsp("testables") end, "Rust: Testables")
    map("<leader>rm", function() vim.cmd.RustLsp("expandMacro") end, "Rust: Expand Macro")
    map("<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Rust: Open Cargo.toml")
    map("<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Rust: Parent Module")
    map("K",          function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Rust: Hover Actions")
    map("<leader>ra", function() vim.cmd.RustLsp("codeAction") end, "Rust: Code Action")
  end,
})
