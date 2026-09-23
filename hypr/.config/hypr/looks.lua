-----------------------
---- LOOK AND FEEL ----
-----------------------
-- https://wiki.hypr.land/Configuring/Variables/

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border   = "rgba(4A6E85ff)",
            inactive_border = "rgba(2C2C2Eff)",
        },
        resize_on_border = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 12,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.92,

        shadow = {
            enabled = true,
            range = 20,
            render_power = 3,
            color = "0xee1a1a1a",
        },

        blur = {
            enabled = true,
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

-- smart gaps: no gaps/border when only one window
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = { top = 10, right = 0, bottom = 0, left = 0 }, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = { top = 10, right = 0, bottom = 0, left = 0 }, gaps_in = 0 })
hl.window_rule({ name = "no-gaps-tv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
hl.window_rule({ name = "no-gaps-f1", match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })
