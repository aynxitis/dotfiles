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
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
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

-- animation tree
hl.animation({ leaf = "windows", enabled = false })
hl.animation({ leaf = "windowsOut", enabled = false })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })

-- smart gaps: no gaps/border when only one window
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = { top = 10, right = 0, bottom = 0, left = 0 }, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = { top = 10, right = 0, bottom = 0, left = 0 }, gaps_in = 0 })
hl.window_rule({ name = "no-gaps-tv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
hl.window_rule({ name = "no-gaps-f1", match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })

----------------------
---- WINDOW RULES ----
----------------------
-- Placement and float rules. Kept here rather than in a sixth file; they are
-- appearance/placement concerns and do not interact with keybinds.

hl.window_rule({ name = "float-pavucontrol", match = { class = "org.pulseaudio.pavucontrol" }, float = true, size = "720 480" })
hl.window_rule({ name = "brave-ws1", match = { class = "brave-browser" }, workspace = "1" })
hl.window_rule({ name = "discord-ws2", match = { class = "discord" }, workspace = "2" })
hl.window_rule({ name = "spotify-ws2", match = { class = "Spotify" }, workspace = "2" })
hl.window_rule({ name = "code-ws4", match = { class = "code" }, workspace = "4" })
hl.window_rule({ name = "obsidian-ws3", match = { class = "md.obsidian.Obsidian" }, workspace = "3" })
