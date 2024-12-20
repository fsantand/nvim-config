return {
  "mfussenegger/nvim-lint",
  event = "InsertEnter",
  config = function ()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = {'eslint_d',},
      json = {'jsonlint',},
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
