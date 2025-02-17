return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local tree = require("nvim-tree")
    local api = require("nvim-tree.api")

    tree.setup({
      view = {
        side = "right"
      },
      filters = {
        enable = false
      },
    });

    vim.keymap.set('n', "<c-b>", function()
      if api.tree.is_tree_buf(vim.api.nvim_get_current_buf()) then
        api.tree.close()
      else
        api.tree.open()
      end
    end)
  end,
}
