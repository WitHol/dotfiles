vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true -- Enable line numbers
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10
vim.opt.wrap = false

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

-- Disabling netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Remove search highlight on esc

-- Open floating terminal with <C-j> 
Termbuf = nil
Termwin = nil
vim.keymap.set({'n', 'i', 'v', 't'}, '<leader>tw', function()
  if Termwin and vim.api.nvim_win_is_valid(Termwin) then
    vim.api.nvim_win_close(Termwin, true)
    Termwin = nil
  else
    local openterm = false;

    if not Termbuf or not vim.api.nvim_buf_is_valid(Termbuf) then
      Termbuf = vim.api.nvim_create_buf(false, true)
      vim.bo[Termbuf].bufhidden = "hide"
      vim.bo[Termbuf].filetype = "terminal"
      openterm = true
    end

    local width = vim.o.columns;
    local height = vim.o.lines;
    Termwin = vim.api.nvim_open_win(Termbuf, true, {
      relative = 'editor',
      row = math.floor(height * 0.1),
      col = math.floor(width * 0.1),
      width = math.floor(width * 0.8),
      height = math.floor(height * 0.8),
      style = 'minimal',
      border = 'rounded'
    })

    vim.cmd("startinsert")
    if openterm then
      vim.fn.termopen(vim.o.shell)
    end
  end
end, { desc = "[T]erminal [W]indow" })

-- Rebinding the window resizing, because the default keymap is trash
vim.keymap.set('n', '<C-w><C-]>', '<cmd>resize +4<CR>')
vim.keymap.set('n', '<C-w><C-[>', '<cmd>resize -4<CR>')
vim.keymap.set('n', '<C-w><C-.>', '<cmd>vertical resize +8<CR>')
vim.keymap.set('n', '<C-w><C-,>', '<cmd>vertical resize -8<CR>')

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Tweaking the look of the terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

