local lint = require("lint")

lint.linters_by_ft = {
  python     = { "mypy", "ruff" },
  javascript = { "eslint_d" },
  json       = { "jsonlint" },
}

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    lint.try_lint()
  end,
})
