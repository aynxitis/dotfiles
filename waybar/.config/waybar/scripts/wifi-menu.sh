#!/usr/bin/env bash
#
# wifi-menu.sh -- nmcli + rofi WiFi picker, used by waybar's network module.
#
# Styling comes from ~/.config/rofi/config.rasi, which @theme's theme.rasi, so
# this inherits the palette automatically -- no -theme flag needed.
#
# Replaces nm-applet, which needed a tray to be useful.

set -uo pipefail

WIFI=$''      # nf-fa-wifi
LOCK=$''      # nf-fa-lock
OK=$''        # nf-fa-check
OFF=$''       # nf-fa-chain_broken
ROWS=12

notify() { command -v notify-send >/dev/null 2>&1 && notify-send -a WiFi "$@"; }

# theme.rasi sets Inter, which is proportional and carries no Nerd Font
# glyphs -- the icons below would render as tofu and the columns would not
# line up. Override only the list/entry font; every colour, size and padding
# still comes from theme.rasi.
THEME_STR='element-text { font: "JetBrainsMono Nerd Font 11"; } entry { font: "JetBrainsMono Nerd Font 11"; }'

# rofi wrapper: prints the selected index, or nothing if cancelled
pick() {
    local prompt=$1 rows=$2
    rofi -dmenu -i -no-custom -format i -p "$prompt" -l "$rows" -theme-str "$THEME_STR"
}

iface=$(nmcli -t -f DEVICE,TYPE device 2>/dev/null | awk -F: '$2=="wifi"{print $1; exit}')
if [[ -z ${iface:-} ]]; then
    notify -u critical "No WiFi device found"
    exit 1
fi

# ---- radio off: the only useful action is turning it on --------------------
if [[ $(nmcli -t -f WIFI radio 2>/dev/null) != enabled ]]; then
    if [[ $(printf '%s\n' "$WIFI  Enable WiFi" | pick "WiFi" 1) == 0 ]]; then
        nmcli radio wifi on >/dev/null 2>&1 && notify "WiFi enabled"
    fi
    exit 0
fi

nmcli device wifi rescan >/dev/null 2>&1   # fails harmlessly if rescanned recently

# ---- build the network list ------------------------------------------------
# nmcli -t escapes ':' inside fields as '\:'. Swap those to \x01 before
# splitting on ':', then swap back, so SSIDs containing colons survive.
# Access points are deduplicated by SSID, keeping the strongest signal: a
# single network here advertises eleven of them.
mapfile -t rows < <(
    nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list --rescan no 2>/dev/null \
    | sed 's/\\:/\x01/g' \
    | awk -F: '
        { ssid = $2 }
        ssid == "" { next }
        {
            sig = $3 + 0
            if (!(ssid in best) || sig > best[ssid]) { best[ssid] = sig; sec[ssid] = $4 }
            if ($1 == "*") inuse[ssid] = 1
        }
        END { for (s in best) printf "%d\037%d\037%s\037%s\n", (s in inuse), best[s], sec[s], s }' \
    | sort -t$'\037' -k1,1nr -k2,2nr
)

declare -a ssids secs connected display
for row in "${rows[@]}"; do
    # 0x1f (unit separator), not tab: tab is IFS-whitespace, so an open
    # network's empty SECURITY field would collapse and shift the SSID away.
    IFS=$'\037' read -r in_use signal security ssid <<<"$row"
    ssid=${ssid//$'\x01'/:}
    ssids+=("$ssid")
    secs+=("$security")
    connected+=("$in_use")
    mark="  " ; [[ $in_use == 1 ]] && mark="$OK "
    lock=""   ; [[ -n $security ]] && lock="  $LOCK"
    display+=("$(printf '%s%-28s %3d%%%s' "$mark" "$ssid" "$signal" "$lock")")
done

n=${#ssids[@]}
if (( n == 0 )); then
    notify "No networks found"
    exit 0
fi

entries=("${display[@]}" "$OFF  Turn WiFi off" "$WIFI  Rescan")
idx=$(printf '%s\n' "${entries[@]}" | pick "WiFi" "$ROWS")
[[ -z ${idx:-} ]] && exit 0

# ---- actions ---------------------------------------------------------------
if (( idx == n )); then
    nmcli radio wifi off >/dev/null 2>&1 && notify "WiFi disabled"
    exit 0
fi
if (( idx == n + 1 )); then
    nmcli device wifi rescan >/dev/null 2>&1
    exec "$0"
fi

ssid=${ssids[idx]}
if [[ ${connected[idx]} == 1 ]]; then
    notify "Already connected" "$ssid"
    exit 0
fi

# A saved profile connects without asking for anything.
if nmcli -t -f NAME connection show 2>/dev/null \
     | sed 's/\\:/\x01/g' | tr '\x01' ':' | grep -Fxq -- "$ssid"; then
    if nmcli connection up id "$ssid" >/dev/null 2>&1; then
        notify "Connected" "$ssid"
        exit 0
    fi
    # stale or wrong saved password: fall through and ask
fi

if [[ -n ${secs[idx]} ]]; then
    # theme.rasi's entry placeholder is "Search", which reads oddly on a
    # password field, so blank it for this prompt only.
    pass=$(rofi -dmenu -password -p "Password" -mesg "$(printf '%s' "$ssid")" -l 0 \
                -theme-str "$THEME_STR entry { placeholder: \"\"; }" </dev/null)
    [[ -z ${pass:-} ]] && exit 0
    # The password goes in argv, which is briefly readable in /proc/<pid>/cmdline.
    # The alternatives were worse on this nmcli (1.58.1): `--ask` re-prompts in a
    # loop and hangs forever on a wrong password even with no controlling tty,
    # and `--passwd-file` is not implemented. argv fails fast and cleanly
    # instead, so it is the option that actually works.
    out=$(timeout 45 nmcli device wifi connect "$ssid" password "$pass" 2>&1)
    rc=$?
    unset pass
else
    out=$(timeout 45 nmcli device wifi connect "$ssid" 2>&1)
    rc=$?
fi

if (( rc == 0 )); then
    notify "Connected" "$ssid"
else
    notify -u critical "Could not connect to $ssid" "${out##*: }"
fi
