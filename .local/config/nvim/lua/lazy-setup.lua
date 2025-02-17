-- NOTE: Intsalling lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- NOTE: Auto detects tab width
  { 'j-hui/fidget.nvim', opts = {} },

  -- NOTE: Shows plugins loading in the bottom right corner
  { 'tpope/vim-sleuth' },

  -- NOTE: Displays keymaps while typing them
  require('plugins.which-key'), -- folke/which-key.nvim

  -- NOTE: Highlight notes, comments, warns, etc.
  require('plugins.todo-comments'), -- folke/todo-comments.nvim

  -- NOTE: Better opening screen
  require('plugins.alpha-nvim'), -- goolord/alpha-nvim 

  -- NOTE: Statusline
  require('plugins.lualine'), -- nvim-lualine/lualine.nvim

  -- NOTE: Color scheme
  require('plugins.tokyonight'), -- folke/tokyonight.nvim

  -- NOTE: Fuzzy finder
  require('plugins.telescope'), -- nvim-telescope/telescope.nvim

  -- NOTE: Lua lsp plugin
  require('plugins.lazydev'), -- folke/lazydev.nvim

  -- NOTE: Helps manage rust crates in cargo.toml files
  require('plugins.crates'), -- saecki/crates.nvim

  -- NOTE: Main LSP Configuration
  require('plugins.lspconfig'), -- neovim/nvim-lspconfig

  -- NOTE: Autocompletion
  require('plugins.cmp'), -- hrsh7th/nvim-cmp

  -- NOTE: File manager
  require('plugins.tree'), -- nvim-tree/nvim-tree.lua
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

