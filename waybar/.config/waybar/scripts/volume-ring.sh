#!/usr/bin/env bash
# Draws the volume pill for waybar's image#volume module: the speaker icon
# inside a ring whose white arc is the volume (full circle = 100%).
# Prints the SVG path, then the tooltip, as the image module expects.

out="${XDG_RUNTIME_DIR:-/tmp}/waybar-volume-ring.svg"

read -r _ vol muted < <(wpctl get-volume @DEFAULT_AUDIO_SINK@)
pct=$(awk -v v="${vol:-0}" 'BEGIN { printf "%d", v * 100 + 0.5 }')

fg="#E8E8ED"
if [[ "$muted" == "[MUTED]" ]]; then
    icon=$''
    arc=0
elif (( pct < 34 )); then
    icon=$''
    arc=$pct
elif (( pct < 67 )); then
    icon=$''
    arc=$pct
else
    icon=$''
    arc=$pct
fi
(( arc > 100 )) && arc=100

# Ring geometry in a 64x64 box: radius 28, stroke 5.
r=28
dash=$(awk -v r="$r" -v a="$arc" 'BEGIN { c = 2 * 3.14159265 * r; printf "%.2f %.2f", c * a / 100, c }')
arc_el=""
(( arc > 0 )) && arc_el="<circle cx=\"32\" cy=\"32\" r=\"$r\" fill=\"none\" stroke=\"$fg\" stroke-width=\"5\" stroke-linecap=\"round\" stroke-dasharray=\"$dash\" transform=\"rotate(-90 32 32)\"/>"

cat > "$out.tmp" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <circle cx="32" cy="32" r="$r" fill="none" stroke="$fg" stroke-opacity="0.25" stroke-width="5"/>
  $arc_el
  <text x="30" y="33" fill="$fg" font-family="JetBrainsMono Nerd Font" font-size="30" text-anchor="middle" dominant-baseline="central">$icon</text>
</svg>
EOF
mv -f "$out.tmp" "$out"

echo "$out"
if [[ "$muted" == "[MUTED]" ]]; then
    echo "Muted ($pct%)"
else
    echo "Volume $pct%"
fi
