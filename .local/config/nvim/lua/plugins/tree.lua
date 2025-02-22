return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("nvim-tree").setup({
      view = {
        side = "right",
      },
      filters = {
        enable = false,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    });

    local api = require("nvim-tree.api")

    -- Open floating terminal with <C-j> 
    Treewin = nil
    vim.keymap.set({'n', 'i', 'v', 't'}, '<leader>fm', function()
      if Treewin and vim.api.nvim_win_is_valid(Treewin) then
        vim.api.nvim_win_close(Treewin, true)
        Treewin = nil
      else
        local width = vim.o.columns;
        local height = vim.o.lines;

        Treewin = vim.api.nvim_open_win( vim.api.nvim_create_buf(false, true), true, {
          relative = 'editor',
          row = math.floor(height * 0.1),
          col = math.floor(width * 0.1),
          width = math.floor(width * 0.8),
          height = math.floor(height * 0.8),
          style = 'minimal',
          border = 'rounded'
        })

        api.tree.open({current_window = true})
      end
    end, { desc = "[F]ile [M]anager" } )

  end,
}
