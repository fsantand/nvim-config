-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "tsx",
        "javascript",
        "typescript",
        "vimdoc",
        "vim",
        "bash",
        "jsdoc",
        "query",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { enable = true, disable = {"dockerfile"} },
      indent = { enable = true },
    }
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.bruno = {
      install_info = {
        url = "~/ts/tree-sitter-bruno", -- local path or git repo
        files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
        generate_requires_npm = true, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = true,
      },
      filetype = "bru", -- if filetype does not match the parser name
    }
    vim.treesitter.language.register('markdown', 'octo')

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
