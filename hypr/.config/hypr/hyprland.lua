--
-- ~/.config/hypr/hyprland.lua
--
-- Entry point only. Everything lives in the modules below; edit those.
-- Module search path is rooted at this directory:
--   package.path = /home/anis/.config/hypr/?.lua; ...
-- so require("looks") loads ./looks.lua.
--
-- Reference:
--   example config : /usr/share/hypr/hyprland.lua
--   typed API stub : /usr/share/hypr/stubs/hl.meta.lua
--   wiki           : https://wiki.hypr.land/
--

require("monitors")    -- outputs, modes, scale
require("env")         -- environment variables
require("autostart")   -- exec on hyprland.start
require("looks")       -- general / decoration / animations / window rules
require("binds")       -- keybinds and submaps
