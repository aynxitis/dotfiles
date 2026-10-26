#!/usr/bin/env bash
# Run by waybar as the hidden custom/volume-watch module. Prints nothing; on
# every sink or default-device change it sends SIGRTMIN+8 so image#volume
# redraws at once, including for the volume keys (which call pactl directly).

pactl subscribe | grep --line-buffered -E "on (sink|server) " | while read -r _; do
    pkill -RTMIN+8 -x waybar
done
