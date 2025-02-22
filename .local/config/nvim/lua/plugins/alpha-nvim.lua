return {
  "goolord/alpha-nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
        "                                                    ",
    }


    dashboard.section.buttons.val = {
      dashboard.button('n', '  >  new file', '<cmd>ene!<CR>'),
      dashboard.button('f', '  >  file manager', "<cmd>e .<CR>"),
    }

    require("alpha").setup(dashboard.opts)
  end,
}
