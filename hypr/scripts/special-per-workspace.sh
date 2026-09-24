#!/usr/bin/env sh
#
# Give every workspace its own scratchpad.
#
# Toggles, or moves the focused window into, "special:s<N>" where <N> is the
# workspace you are currently on. Reads the focused monitor's activeWorkspace
# rather than `hyprctl activeworkspace`, because the latter reports the special
# workspace itself once one is showing, which would give a negative id.

ws="$(hyprctl monitors -j | jq -r 'map(select(.focused)) | .[0].activeWorkspace.id')"

case "$ws" in
'' | null)
    echo "Could not determine the focused workspace" >&2
    exit 1
    ;;
esac

# hl.dsp.* only builds a dispatcher descriptor; hl.dispatch() is what runs it
case "$1" in
move) hyprctl dispatch movetoworkspace "special:s$ws" >/dev/null ;;
'') hyprctl dispatch togglespecialworkspace "s$ws" >/dev/null ;;
*)
    echo "Usage: ${0##*/} [move]" >&2
    exit 1
    ;;
esac
