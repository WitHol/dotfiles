-- Disabling netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true -- Enable line numbers
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

vim.opt.splitbelow = true -- Make vertical splits appear at the bottom
vim.opt.splitright = true -- Make horizontal splits appear at the right
vim.opt.mouse = 'a' -- Enable mouse mode, it allows for eg. resizing splits
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tab configuration
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>') -- Remove search highlight on esc

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.filetype.add({
  extension = {
    asm = "nasm",
  }
})

