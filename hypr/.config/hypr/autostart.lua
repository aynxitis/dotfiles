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
    hl.exec_cmd("nm-applet")
    -- Waybar runs with its own XDG_CONFIG_HOME so it picks up a LIGHT icon
    -- theme for the tray (the bar has light glass pills; Papirus-Dark panel
    -- icons are near-white and wash out). Its own config/style are passed
    -- explicitly because overriding XDG_CONFIG_HOME moves the default lookup.
    -- System-wide GTK theming is untouched.
    hl.exec_cmd("env XDG_CONFIG_HOME=$HOME/.config/waybar-gtk waybar -c $HOME/.config/waybar/config.jsonc -s $HOME/.config/waybar/style.css")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprctl setcursor macOS 24")

    -- apps
    hl.exec_cmd("brave")
    hl.exec_cmd("code")
    hl.exec_cmd("spotify")
    hl.exec_cmd("discord")
end)
