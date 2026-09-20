#!/usr/bin/env bash
# mic-mute-all.sh [mute|unmute]   (no arg = toggle)
mapfile -t sources < <(pactl list short sources | grep -v '\.monitor' | awk '{print $2}')
[ ${#sources[@]} -eq 0 ] && exit 0
case "$1" in
    mute)   target=1 ;;
    unmute) target=0 ;;
    *)  state=$(pactl get-source-mute "${sources[0]}" | awk '{print $2}')
        [ "$state" = "yes" ] && target=0 || target=1 ;;
esac
for s in "${sources[@]}"; do
    pactl set-source-mute "$s" "$target"
done
[ "$target" = 1 ] && notify-send "Mic" "ALL mics muted" || notify-send "Mic" "Mics live"
