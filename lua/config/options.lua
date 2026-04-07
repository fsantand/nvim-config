vim.g.mapleader = " "
vim.g.maplocalleader = "\\ "

vim.o.mouse = ""
vim.o.termguicolors = true
vim.o.completeopt = "menu,menuone,noinsert,popup"
vim.o.undofile = true
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.clipboard = "unnamedplus"
vim.o.showmode = false

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.markdown_fenced_languages = {
  "ts=typescript",
  "typescript=typescript",
}
