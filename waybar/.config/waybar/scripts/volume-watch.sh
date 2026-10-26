#!/usr/bin/env bash
# Run by waybar as the hidden custom/volume-watch module. Prints nothing; on
# every sink or default-device change it sends SIGRTMIN+8 to its waybar so
# image#volume redraws at once, including for the volume keys (which call
# pactl directly).
#
# waybar does not take this script's children with it when it is killed, so
# the script watches its parent and exits (stopping pactl) once waybar is
# gone, instead of being left running.

waybar_pid=$PPID

while kill -0 "$waybar_pid" 2>/dev/null; do
    exec 3< <(pactl subscribe)
    pactl_pid=$!
    trap 'kill "$pactl_pid" 2>/dev/null' EXIT

    while kill -0 "$waybar_pid" 2>/dev/null; do
        if read -r -t 5 line <&3; then
            [[ "$line" == *" on sink "* || "$line" == *" on server "* ]] &&
                kill -RTMIN+8 "$waybar_pid" 2>/dev/null
        elif (( $? <= 128 )); then
            break # pactl exited (e.g. PipeWire restarted): start it again
        fi
    done

    kill "$pactl_pid" 2>/dev/null
    exec 3<&-
    sleep 1
done
