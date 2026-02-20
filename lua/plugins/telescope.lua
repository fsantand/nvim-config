local file_ignore_patterns = {
  "yarn%.lock",
  "node_modules/",
  "raycast/",
  "dist/",
  "%.next",
  "%.git/",
  "%.gitlab/",
  "build/",
  "target/",
  "package%-lock%.json",
}
--UI for searching
return {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  tag="0.1.8",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  keys = function()
    local telescope_builtins = require("telescope.builtin")
    local find_current_word = function()
      local word = vim.fn.expand("<cword>")
      telescope_builtins.grep_string({ search = word })
    end

    local find_config_files = function()
      telescope_builtins.find_files({ cwd = "~/.config/nvim" })
    end

    local grep_config_files = function()
      telescope_builtins.live_grep({ cwd = "~/.config/nvim" })
    end

    local grep_ignore_files = function()
      telescope_builtins.live_grep({ file_ignore_patterns = file_ignore_patterns})
    end

    return {
      --{ "<leader>po", telescope_builtins.lsp_dynamic_workspace_symbols, { desc = "Find lsp workspace symbols" } },
      --{ "<leader>pb", telescope_builtins.git_branches, { desc = "Switch branches" } },
      --{ "<leader>pws", find_current_word, { desc = "Find current word in files" } },
      --{ "<leader>so", telescope_builtins.lsp_document_symbols, { desc = "Treesitter symbols" } },
    }
  end,
  opts = function()
    pcall(require("telescope").load_extension, "fzf")

    return {
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = file_ignore_patterns,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    }
  end,
}
