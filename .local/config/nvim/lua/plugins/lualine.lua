return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  opts = {
    options = {
      theme = "auto",
      component_separators = { left = ":", right = ":" },
      section_separators = { left = "", right = "" },
    },

    sections = {
      lualine_a = {"mode"},
      lualine_b = {"branch", "diff"},
      lualine_c = {"filename"},

      lualine_x = {"encoding", "filetype", "fileformat"},
      lualine_y = {"progress"},
      lualine_z = {"location"},
    },

    extensions = {
    },
  },
}
