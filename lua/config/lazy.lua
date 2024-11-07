-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Global config
vim.g.mapleader = " "
vim.o.mouse = ""
vim.o.termguicolors = true
vim.g.maplocalleader = "\\ "
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = ""
vim.o.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = 'menu,menuone,noinsert'
vim.cmd([["filetype plugin on"]])

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.undofile = true
vim.o.breakindent = true
vim.wo.signcolumn = "yes"
vim.wo.conceallevel = 2

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keymaps and random shit
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move to next half page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move to prev half page" })
vim.keymap.set("n", "<leader>rn", ":set relativenumber!<CR>", { silent = true, desc = "Move to prev half page" })

-- [[ Diagnostics ]]
local open_float = function()
  return vim.diagnostic.open_float({ border = "rounded" })
end

local goto_next_diag = function()
  return vim.diagnostic.goto_next({ border = "rounded" })
end

local goto_prev_diag = function()
  return vim.diagnostic.goto_prev({ border = "rounded" })
end

vim.keymap.set("n", "<leader>vd", open_float, { desc = "Open diagnostic" })
vim.keymap.set("n", "]d", goto_next_diag, { desc = "Diagnostics: Go to next" })
vim.keymap.set("n", "[d", goto_prev_diag, { desc = "Diagnostics: Go to previous" })


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    {
      "rebelot/kanagawa.nvim",
      config = function()
        require('kanagawa').setup({
          transparent = true,
        })
        vim.cmd[[colorscheme kanagawa]]
      end
    },
    {
      "nyoom-engineering/oxocarbon.nvim",
      config = function()
        vim.cmd[[colorscheme oxocarbon]]
      end,
      enabled = false,
    },
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "kanagawa" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
