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
    -- Tray icons: nm-applet is remapped to a symbolic icon in waybar's config,
    -- which GTK recolours from the CSS `color` on #tray. That keeps the tray
    -- readable on the light pills without overriding XDG_CONFIG_HOME, which
    -- used to leak into anything an on-click launched.
    hl.exec_cmd("waybar")
    -- nm-applet must start AFTER waybar's StatusNotifierWatcher exists, and as
    -- early as possible once it does. Tray order is registration order (waybar
    -- displays it reversed), and Cloudflare WARP -- already running under
    -- warp-taskbar.service -- only re-registers once the watcher reappears,
    -- which it does slowly. Registering nm-applet first therefore puts WARP
    -- last, which renders it leftmost. gdbus wait removes the startup race
    -- that a bare ordering or a fixed sleep would leave behind.
    hl.exec_cmd("sh -c 'gdbus wait --session --timeout 15 org.kde.StatusNotifierWatcher && exec nm-applet'")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprctl setcursor macOS 24")

    -- apps
    hl.exec_cmd("brave")
    hl.exec_cmd("code")
    hl.exec_cmd("spotify")
    hl.exec_cmd("discord")
end)
