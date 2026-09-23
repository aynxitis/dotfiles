------------------
---- MONITORS ----
------------------
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "auto", scale = "1" })

---------------------
---- MY PROGRAMS ----
---------------------
local mainMod  = "SUPER"
local terminal = "kitty"
local menu     = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprctl setcursor macOS 24")
    hl.exec_cmd("brave")
    hl.exec_cmd("code")
    hl.exec_cmd("spotify")
    hl.exec_cmd("discord")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------
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
---- KEYBINDINGS -----
----------------------
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + semicolon", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind("ALT + Tab", hl.dsp.focus({ direction = "d" }))
hl.bind("ALT + SHIFT + Tab", hl.dsp.focus({ direction = "u" }))

hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.swap({ direction = "r" }))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("J", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("semicolon", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("Return", hl.dsp.submap("reset"))
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +10%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -10%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))

hl.bind("Print", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))

----------------------
---- WINDOW RULES ----
----------------------
hl.window_rule({ name = "float-pavucontrol", match = { class = "org.pulseaudio.pavucontrol" }, float = true, size = "720 480" })
hl.window_rule({ name = "brave-ws1", match = { class = "brave-browser" }, workspace = "1" })
hl.window_rule({ name = "discord-ws2", match = { class = "discord" }, workspace = "2" })
hl.window_rule({ name = "spotify-ws2", match = { class = "Spotify" }, workspace = "2" })
hl.window_rule({ name = "code-ws4", match = { class = "code" }, workspace = "4" })
hl.window_rule({ name = "obsidian-ws3", match = { class = "md.obsidian.Obsidian" }, workspace = "3" })
