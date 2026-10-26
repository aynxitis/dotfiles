#!/usr/bin/env bash
# Draws the volume pill for waybar's image#volume module: the same icon the
# pulseaudio module showed, plus a white line along the pill's own outline,
# starting at the top and running clockwise; once round the pill = 100%.
# The pill background and shape stay in style.css; this SVG only overlays
# the icon and the outline. Prints the SVG path, then the tooltip.

out="${XDG_RUNTIME_DIR:-/tmp}/waybar-volume-ring.svg"

# One pactl call: default sink's volume, mute and whether it is headphones.
read -r pct muted phones < <(pactl --format=json list sinks | python3 -I -c '
import json, subprocess, sys
default = subprocess.run(["pactl", "get-default-sink"], capture_output=True, text=True).stdout.strip()
for s in json.load(sys.stdin):
    if s["name"] == default:
        vols = [int(v["value_percent"].rstrip("%")) for v in s["volume"].values()]
        port = (s.get("active_port") or "").lower()
        ff = s.get("properties", {}).get("device.form_factor", "")
        phones = "headphone" in port or "headset" in port or ff in ("headphone", "headset")
        print(max(vols), int(s["mute"]), int(phones))
        break
else:
    print(0, 0, 0)
')

fg="#E8E8ED"
if (( muted )); then
    icon=$''
elif (( phones )); then
    icon=$''
elif (( pct < 34 )); then
    icon=$''
elif (( pct < 67 )); then
    icon=$''
else
    icon=$''
fi
arc=$pct
(( muted )) && arc=0
(( arc > 100 )) && arc=100

# Pill box matches the old pulseaudio pill: 33x30, fully rounded ends.
# The outline path is inset by half the stroke so the line sits inside the
# pill edge. pathLength=100 makes the dash length equal the percentage.
w=33 h=30 s=2
i=$(awk -v s="$s" 'BEGIN { print s / 2 }')
r=$(awk -v h="$h" -v i="$i" 'BEGIN { print h / 2 - i }')
outline="M $(awk -v w="$w" 'BEGIN { print w / 2 }') $i \
H $(awk -v w="$w" -v h="$h" 'BEGIN { print w - h / 2 }') \
A $r $r 0 0 1 $(awk -v w="$w" -v h="$h" 'BEGIN { print w - h / 2 }') $(awk -v h="$h" -v i="$i" 'BEGIN { print h - i }') \
H $(awk -v h="$h" 'BEGIN { print h / 2 }') \
A $r $r 0 0 1 $(awk -v h="$h" 'BEGIN { print h / 2 }') $i Z"

arc_el=""
(( arc > 0 )) && arc_el="<path d=\"$outline\" pathLength=\"100\" fill=\"none\" stroke=\"$fg\" stroke-width=\"$s\" stroke-linecap=\"round\" stroke-dasharray=\"$arc 100\"/>"

# Icon placed like the old pill: 10px left padding, 14px glyph.
cat > "$out.tmp" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="$w" height="$h" viewBox="0 0 $w $h">
  $arc_el
  <text x="10" y="$(( h / 2 ))" fill="$fg" font-family="JetBrainsMono Nerd Font" font-size="14" dominant-baseline="central">$icon</text>
</svg>
EOF
mv -f "$out.tmp" "$out"

echo "$out"
if (( muted )); then
    echo "Muted ($pct%)"
else
    echo "Playing at $pct%"
fi
