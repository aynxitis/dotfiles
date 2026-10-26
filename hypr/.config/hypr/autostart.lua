-------------------
---- AUTOSTART ----
-------------------
-- https://wiki.hypr.land/Configuring/Basics/Autostart/
-- Runs once per Hyprland start. Not re-run by `hyprctl reload`.

hl.on("hyprland.start", function()
    -- session services
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("hypridle")
    -- keeps track of the most recently active MPRIS player, so a bare
    -- `playerctl` (what the media keys call) targets whatever you last used
    -- instead of whichever player happened to register first.
    hl.exec_cmd("playerctld daemon")

    -- shell
    -- No tray, and no nm-applet: the network module's on-click opens a
    -- nmcli+rofi picker instead (waybar/scripts/wifi-menu.sh).
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    -- awww restores the last wallpaper from its cache on start.
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("hyprctl setcursor macOS 24")

    -- apps
    hl.exec_cmd("brave")
    hl.exec_cmd("spotify")
    hl.exec_cmd("discord")
end)
