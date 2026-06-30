#!/bin/bash

led_file=$(ls /sys/class/leds/*capslock*/brightness 2>/dev/null | head -n 1)

last_state=""

if [ -z "$led_file" ]; then
    echo '{"text":" ","class":"unlocked"}'
    exit 0
fi

while true; do
    state=$(cat "$led_file" 2>/dev/null)
    if [ "$state" != "$last_state" ]; then
        if [ "$state" = "1" ]; then
            echo '{"text":"CAPS","class":"locked"}'
        else
            echo '{"text":" ","class":"unlocked"}'
        fi
        last_state="$state"
    fi
    sleep 0.1
done
