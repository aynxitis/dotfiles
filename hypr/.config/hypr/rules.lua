----------------------
---- WINDOW RULES ----
----------------------
-- https://wiki.hypr.land/Configuring/Window-Rules/
-- Placement and float rules, applied as windows open.
--
-- Note: the no-gaps rules for w[tv1] / f[1] deliberately stay in looks.lua.
-- They are one half of the smart-gaps behaviour and only make sense next to
-- the workspace_rule calls they pair with.

hl.window_rule({ name = "float-pavucontrol", match = { class = "org.pulseaudio.pavucontrol" }, float = true, size = "720 480" })
hl.window_rule({ name = "brave-ws1", match = { class = "brave-browser" }, workspace = "1" })
hl.window_rule({ name = "discord-ws2", match = { class = "discord" }, workspace = "2" })
hl.window_rule({ name = "spotify-ws2", match = { class = "Spotify" }, workspace = "2" })
hl.window_rule({ name = "code-ws4", match = { class = "code" }, workspace = "4" })
hl.window_rule({ name = "obsidian-ws3", match = { class = "md.obsidian.Obsidian" }, workspace = "3" })
