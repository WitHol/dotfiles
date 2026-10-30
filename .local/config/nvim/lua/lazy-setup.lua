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
  -- Shows plugins loading in the bottom right corner
  { 'j-hui/fidget.nvim', opts = {} },

  -- Auto detects tab width
  { 'tpope/vim-sleuth' },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },

  {
    'folke/tokyonight.nvim',
     priority = 1000,
     init = function() vim.cmd.colorscheme('tokyonight-night') end,
  },

  -- For cargo.toml files
  {
    "saecki/crates.nvim",
    tag = 'stable',
    event = { "BufRead Cargo.toml" },
    config = function()
      require('crates').setup()
    end,
  },
  
  -- Pitchfork
  { dir = "~/projekty/pitchfork.nvim/", opts = {} },

  -- Suggests keymaps while typing
  require('plugins.which-key'),

  -- Better status line
  require('plugins.lualine'),

  -- Fuzzy finder
  require('plugins.telescope'), 

  -- Better opening screen
  require('plugins.alpha-nvim'),

  -- Main LSP Configuration
  require('plugins.lspconfig'),

  -- Autocompletion
  require('plugins.cmp'), 

  -- File manager
  require('plugins.tree'), 
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

