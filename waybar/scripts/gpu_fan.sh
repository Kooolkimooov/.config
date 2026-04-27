#!/bin/sh

if command -v nvidia-smi >/dev/null 2>&1; then
  f=$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits 2>/dev/null | head -n1 | tr -d ' %')
  case "$f" in
    ""|"N/A"|"[N/A]") ;;
    *)
      echo "GPU FAN ${f}%"
      exit 0
      ;;
  esac
fi

g=""
for d in /sys/class/hwmon/hwmon*; do
  [ -r "$d/name" ] || continue
  n=$(cat "$d/name" 2>/dev/null)
  [ "$n" = "amdgpu" ] || continue

  if [ -r "$d/pwm1" ]; then
    pwm=$(cat "$d/pwm1" 2>/dev/null)
    pwmmax=255
    [ -r "$d/pwm1_max" ] && pwmmax=$(cat "$d/pwm1_max" 2>/dev/null)
    if [ -n "$pwm" ] && [ -n "$pwmmax" ] && [ "$pwmmax" -gt 0 ] 2>/dev/null; then
      g=$((pwm * 100 / pwmmax))
    fi
  fi

  if [ -z "$g" ] && [ -r "$d/fan1_input" ] && [ -r "$d/fan1_max" ]; then
    rpm=$(cat "$d/fan1_input" 2>/dev/null)
    max=$(cat "$d/fan1_max" 2>/dev/null)
    if [ -n "$rpm" ] && [ -n "$max" ] && [ "$max" -gt 0 ] 2>/dev/null; then
      g=$((rpm * 100 / max))
    fi
  fi

  [ -n "$g" ] && break
done

if [ -n "$g" ]; then
  echo "GPU FAN ${g}%"
else
  echo "GPU FAN N/A"
fi
