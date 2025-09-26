return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require('fff.download').download_or_build_binary()
  end,
  -- or if you are using nixos
  -- build = "nix run .#release",
  opts = {
    -- pass here all the options
  },
  keys = {
    {
      "<leader>pf",                 -- try it if you didn't it is a banger keybinding for a picker
      function()
        require("fff").find_in_git_root() -- or find_in_git_root() if you only want git files
      end,
      desc = "FFF: Find git files",
    },
    {
      "<leader>pa",                 -- try it if you didn't it is a banger keybinding for a picker
      function()
        require("fff").find_files() -- or find_in_git_root() if you only want git files
      end,
      desc = "FFF: Find all files",
    },
    {
      "<leader>pcf",                 -- try it if you didn't it is a banger keybinding for a picker
      function()
        require("fff").find_files_in_dir('~/.config/nvim/') -- or find_in_git_root() if you only want git files
      end,
      desc = "FFF: Find all files",
    }
  },
}
