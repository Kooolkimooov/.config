#!/bin/sh

# Show CAPS when any keyboard capslock LED is on.
for led in /sys/class/leds/*capslock*/brightness; do
  [ -r "$led" ] || continue
  if [ "$(cat "$led" 2>/dev/null)" = "1" ]; then
    printf '{"text":"CAPS","class":"locked"}\n'
    exit 0
  fi
done

printf '{"text":" ","class":"unlocked"}\n'
