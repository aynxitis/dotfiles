-------------------
---- AUTOSTART ----
-------------------
-- https://wiki.hypr.land/Configuring/Basics/Autostart/
-- Runs once per Hyprland start. Not re-run by `hyprctl reload`.

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
