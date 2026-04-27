#!/bin/sh

p=""
for d in /sys/class/hwmon/hwmon*; do
  [ -r "$d/name" ] || continue
  n=$(cat "$d/name" 2>/dev/null)
  [ "$n" = "amdgpu" ] && continue
  [ -r "$d/fan2_input" ] || continue

  if [ -r "$d/fan2_max" ]; then
    rpm=$(cat "$d/fan2_input" 2>/dev/null)
    max=$(cat "$d/fan2_max" 2>/dev/null)
    if [ -n "$rpm" ] && [ -n "$max" ] && [ "$max" -gt 0 ] 2>/dev/null; then
      p=$((rpm * 100 / max))
    fi
  fi

  if [ -z "$p" ] && [ -r "$d/pwm2" ]; then
    pwm=$(cat "$d/pwm2" 2>/dev/null)
    pwmmax=255
    [ -r "$d/pwm2_max" ] && pwmmax=$(cat "$d/pwm2_max" 2>/dev/null)
    if [ -n "$pwm" ] && [ -n "$pwmmax" ] && [ "$pwmmax" -gt 0 ] 2>/dev/null; then
      p=$((pwm * 100 / pwmmax))
    fi
  fi

  [ -n "$p" ] && break
done

if [ -n "$p" ]; then
  echo "CPU FAN ${p}%"
else
  echo "CPU FAN N/A"
fi
