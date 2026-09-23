------------------------------
---- ENVIRONMENT VARIABLES ----
------------------------------
-- https://wiki.hypr.land/Configuring/Environment-variables/
--
-- These are exported into the session, so they reach programs Hyprland
-- launches. Changes need a fresh login to take full effect; `hyprctl reload`
-- will not re-export them to already-running processes.

-- Cursor. GTK reads the theme from gtk-3.0/settings.ini and gsettings, but
-- XWayland clients and toolkits that skip GTK rely on these instead. Without
-- them they fall back to the Adwaita cursor that
-- /usr/share/icons/default/index.theme inherits.
hl.env("XCURSOR_THEME", "macOS")
hl.env("XCURSOR_SIZE", "24")
