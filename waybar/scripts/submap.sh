#!/bin/bash
trap "pkill -P $$" EXIT
echo '{"text":" ","class":"inactive"}'
nc -U $XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    if [[ "$line" == "submap>>"* ]]; then
        current_submap="${line#submap>>}"
        if [ -z "$current_submap" ]; then
            echo '{"text":" ","class":"inactive"}'
        else
            echo '{"text":"'"$current_submap"'","class":"active"}'
        fi
    fi
done
