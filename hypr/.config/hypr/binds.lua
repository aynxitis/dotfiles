----------------------
---- KEYBINDINGS -----
----------------------
-- https://wiki.hypr.land/Configuring/Binds/
-- Direction keys are j/k/l/semicolon = left/down/up/right, matching the i3
-- session's bindings.

---------------------
---- MY PROGRAMS ----
---------------------
local mainMod  = "SUPER"
local terminal = "kitty"
local menu     = "rofi -show drun"

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
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("wlogout"))

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("J", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("semicolon", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("Return", hl.dsp.submap("reset"))
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +10%"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -10%"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true })

-- Media transport. locked = true is the Lua equivalent of hyprlang bindl,
-- so these still work while hyprlock is up.
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("Print", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
