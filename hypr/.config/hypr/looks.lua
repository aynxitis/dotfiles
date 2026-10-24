-----------------------
---- LOOK AND FEEL ----
-----------------------
-- https://wiki.hypr.land/Configuring/Variables/

hl.config({
    general = {
        gaps_in = 7,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border   = "rgb(C6D0F5)",
            inactive_border = "rgb(303446)",
        },
        resize_on_border = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.85,

        shadow = {
            enabled = true,
            range = 20,
            render_power = 3,
            color = "0xee121212",
        },

        blur = {
            enabled = false,
            size = 6,
            passes = 3,
            vibrancy = 0.17,
        },
    },

    animations = { enabled = true },

    dwindle = { preserve_split = true },
    misc = { disable_hyprland_logo = true, disable_splash_rendering = true },
})

-- curves
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

-- animation tree
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })

-- A lone tiled window keeps its gaps and rounding but drops the border.
hl.window_rule({ name = "no-border-tv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
