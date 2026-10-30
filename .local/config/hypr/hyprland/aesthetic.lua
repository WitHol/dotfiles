hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 6,
        border_size = 2,

        col = {
            active_border = "#ffffffff",
            inactive_border = "#555555ff",
        }
    },

    decoration = {
        rounding = 1,

        fullscreen_opacity = 1,
        inactive_opacity = 0.8,
        active_opacity = 0.9,

        blur = {
            size = 8,
            noise = 0.1,
        },

        shadow = {
            color = "#000000ee",
            range = 1,
            render_power = 0,
        },

        motion_blur = {
            enabled = true,
        }
    },

    misc = {
        disable_splash_rendering = true,
        disable_hyprland_logo = true,
        force_default_wallpaper = 1,
    },
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 3,
    bezier = "default",
})

