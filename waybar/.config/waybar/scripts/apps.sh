#!/bin/bash
declare -A icon_map=(
    ["brave-browser"]="\uf268"
    ["Brave-browser"]="\uf268"
    ["firefox"]="\uf269"
    ["kitty"]="\uf120"
    ["Spotify"]="\uf1bc"
    ["discord"]="\uf392"
    ["Code"]="\uf121"
    ["code"]="\uf121"
    ["thunar"]="\uf07b"
    ["nautilus"]="\uf07b"
    ["nemo"]="\uf07b"
)

classes=$(hyprctl clients -j | jq -r '.[].class' | awk '!seen[$0]++' | head -n 3)

out=""
tooltip=""
while IFS= read -r class; do
    [ -z "$class" ] && continue
    icon="${icon_map[$class]:-\uf2d0}"
    out="$out<span font_family='Font Awesome 7 Free'>$icon</span>  "
    tooltip="$tooltip$class, "
done <<< "$classes"

python3 -c "
import json
print(json.dumps({'text': '''$out'''.strip(), 'tooltip': '''${tooltip%, }'''}))
"
