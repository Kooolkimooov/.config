#!/usr/bin/env bash

# Idle Inhibitor Toggle Script for Hyprland & Waybar
# Created by Antigravity

PID_FILE="/tmp/waybar-idle-inhibitor.pid"
STATE_FILE="/tmp/waybar-idle-inhibitor.state"

# Toggle method: "systemd" or "hypridle"
# - "systemd": Runs systemd-inhibit in the background (recommended, keeps hypridle running).
# - "hypridle": Kills the hypridle process (very reliable, works under any config).
METHOD="systemd"

# Icons (Nerd Fonts)
ICON_ACTIVE=""      # Eye open (Keeping system awake)
ICON_INACTIVE=""    # Eye closed (Normal idle behavior)

# Force Waybar custom module to refresh immediately
# Custom module config in Waybar must have "signal": 10
signal_waybar() {
    pkill -RTMIN+10 waybar 2>/dev/null
}

is_active() {
    if [ "$METHOD" = "systemd" ]; then
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if kill -0 "$PID" 2>/dev/null; then
                # Ensure it's actually systemd-inhibit or sleep
                if ps -p "$PID" -o comm= | grep -E -q "systemd-inhibit|sleep"; then
                    return 0 # Active
                fi
            fi
        fi
        return 1 # Inactive
    elif [ "$METHOD" = "hypridle" ]; then
        # If hypridle is NOT running, inhibitor is active (system kept awake)
        if pgrep -x "hypridle" >/dev/null; then
            return 1 # Inactive
        else
            return 0 # Active
        fi
    fi
}

toggle() {
    if is_active; then
        # Deactivate inhibitor (allow sleep)
        if [ "$METHOD" = "systemd" ]; then
            if [ -f "$PID_FILE" ]; then
                PID=$(cat "$PID_FILE")
                kill "$PID" 2>/dev/null
                pkill -P "$PID" 2>/dev/null # Kill sleep child process
                rm -f "$PID_FILE"
            fi
        elif [ "$METHOD" = "hypridle" ]; then
            # Restart hypridle. Try to start it via systemd user service if loaded,
            # otherwise start it as a background process.
            if systemctl --user is-enabled hypridle.service >/dev/null 2>&1; then
                systemctl --user start hypridle.service 2>/dev/null
            fi
            # Double check if it started, otherwise run manually
            if ! pgrep -x "hypridle" >/dev/null; then
                hypridle & disown
            fi
        fi
        echo "deactivated" > "$STATE_FILE"
    else
        # Activate inhibitor (keep awake)
        if [ "$METHOD" = "systemd" ]; then
            # Use nohup and disown to ensure it survives shell exits
            nohup systemd-inhibit --what=idle --why="Manual inhibitor toggle" sleep infinity >/dev/null 2>&1 &
            echo "$!" > "$PID_FILE"
            disown
        elif [ "$METHOD" = "hypridle" ]; then
            # Stop hypridle via systemd service if running, otherwise killall
            if systemctl --user is-active hypridle.service >/dev/null 2>&1; then
                systemctl --user stop hypridle.service 2>/dev/null
            fi
            killall hypridle 2>/dev/null
        fi
        echo "activated" > "$STATE_FILE"
    fi
    signal_waybar
}

status() {
    if is_active; then
        echo "{\"text\": \"$ICON_ACTIVE\", \"alt\": \"activated\", \"tooltip\": \"Idle Inhibitor: ACTIVE (System kept awake)\", \"class\": \"activated\"}"
    else
        echo "{\"text\": \"$ICON_INACTIVE\", \"alt\": \"deactivated\", \"tooltip\": \"Idle Inhibitor: INACTIVE (Normal behavior)\", \"class\": \"deactivated\"}"
    fi
}

case "$1" in
    toggle)
        toggle
        ;;
    status)
        status
        ;;
    *)
        toggle
        ;;
esac
