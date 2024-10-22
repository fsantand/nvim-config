return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  version = "2.3.*",
  config = function()
    local ls = require("luasnip")

    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})
  end
}
