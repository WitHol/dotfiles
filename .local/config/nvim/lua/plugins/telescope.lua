return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Configuring the keybindings
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch existing [B]uffers' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch existing [B]uffers' })
    vim.keymap.set('n', '<leader>s/', builtin.current_buffer_fuzzy_find, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sc',
      function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end,
      { desc = '[S]earch [C]onfig files' })
  end,
}

