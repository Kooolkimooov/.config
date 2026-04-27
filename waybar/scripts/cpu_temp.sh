#!/bin/sh

# Prefer SMBUSMASTER 0, then Tctl, then CPUTIN.
t=$(sensors 2>/dev/null | awk '/^SMBUSMASTER 0:/{gsub(/[+°C]/, "", $3); print $3; exit}')
if [ -z "$t" ]; then
  t=$(sensors 2>/dev/null | awk '/^Tctl:/{gsub(/[+°C]/, "", $2); print $2; exit}')
fi
if [ -z "$t" ]; then
  t=$(sensors 2>/dev/null | awk '/^CPUTIN:/{gsub(/[+°C]/, "", $2); print $2; exit}')
fi

if [ -n "$t" ]; then
  echo "CPU ${t}°C"
else
  echo "CPU N/A"
fi
