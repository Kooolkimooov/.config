#!/bin/sh

if command -v nvidia-smi >/dev/null 2>&1; then
  t=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
  if [ -n "$t" ]; then
    echo "GPU ${t}°C"
  else
    echo "GPU N/A"
  fi
  exit 0
fi

if command -v sensors >/dev/null 2>&1; then
  sensors 2>/dev/null | awk '/edge:|junction:|temp1:/ {gsub(/\+|°C/, "", $2); print "GPU " $2 "°C"; exit}'
  exit 0
fi

echo "GPU N/A"
