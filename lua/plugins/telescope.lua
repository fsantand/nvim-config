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
      --{ "<leader>pf", telescope_builtins.git_files, { desc = "Find repo files" } },
      { "<leader>pe", telescope_builtins.git_status, { desc = "Find changed files" } },
      --{ "<leader>pa", telescope_builtins.find_files, { desc = "Find all files" } },
      { "<leader>pd", telescope_builtins.oldfiles, { desc = "Find old files" } },
      { "<leader>ps", grep_ignore_files, { desc = "Live grep" } },
      { "<leader>po", telescope_builtins.lsp_dynamic_workspace_symbols, { desc = "Find lsp workspace symbols" } },
      { "<leader><leader>", telescope_builtins.buffers, { desc = "Find open buffer" } },
      { "<leader>ph", telescope_builtins.help_tags, { desc = "Find help tags" } },
      { "<leader>pb", telescope_builtins.git_branches, { desc = "Switch branches" } },
      { "<leader>pT", ":Telescope colorscheme enable_preview=true <CR>", { desc = "Switch colorschemes" } },
      --{ "<leader>pcf", find_config_files, { desc = "Find files in nvim config" } },
      { "<leader>pcw", grep_config_files, { desc = "Grep files in nvim config" } },
      { "<leader>pws", find_current_word, { desc = "Find current word in files" } },
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
