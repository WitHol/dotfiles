return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({})

      local toggle_telescope =  function(harpoon_files)
        local conf = require("telescope.config").values
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table( {results = file_paths} ),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc = "[A]dd a harpoon point"} )
      vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, {desc = "[R]emove a harpoon point"} )
      vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Toggle [L]ist menu"} )
    end
}
