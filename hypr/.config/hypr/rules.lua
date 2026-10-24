----------------------
---- WINDOW RULES ----
----------------------
-- https://wiki.hypr.land/Configuring/Window-Rules/
-- Placement and float rules, applied as windows open.
--
-- Note: the no-gaps rules for w[tv1] / f[1] deliberately stay in looks.lua.
-- They are one half of the smart-gaps behaviour and only make sense next to
-- the workspace_rule calls they pair with.

-- Ignore maximize requests from every client. kitty's remember_window_size
-- saves "window-state": "maximized" to ~/.cache/kitty/main.json, and each new
-- kitty then asks to be maximized, covering the other tiled windows.
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({ name = "float-pavucontrol", match = { class = "org.pulseaudio.pavucontrol" }, float = true, size = "720 480" })
hl.window_rule({ name = "brave-ws1", match = { class = "brave-browser" }, workspace = "1" })
hl.window_rule({ name = "discord-ws2", match = { class = "discord" }, workspace = "2" })
hl.window_rule({ name = "spotify-ws2", match = { class = "spotify" }, workspace = "2" })
hl.window_rule({ name = "code-ws4", match = { class = "code" }, workspace = "4" })
hl.window_rule({ name = "obsidian-ws3", match = { class = "md.obsidian.Obsidian" }, workspace = "3" })

---------------------
---- LAYER RULES ----
---------------------
-- https://wiki.hypr.land/Configuring/Window-Rules/#layer-rules
-- decoration:blur (see looks.lua) only affects windows; layer surfaces such as
-- the bar need an explicit rule, which is why the bar was flat translucent
-- white rather than frosted.
--
-- ignore_alpha matters here: waybar's window background is fully transparent
-- and only the pills carry alpha 0.55, so without a threshold the blur would
-- apply across the whole bar strip instead of just the pills.

hl.layer_rule({ name = "blur-waybar", match = { namespace = "waybar" }, blur = true, ignore_alpha = 0.1 })
