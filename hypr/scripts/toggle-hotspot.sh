#!/usr/bin/env sh

is_on="$(nmcli -t -f NAME connection show --active | grep -xc 'Hotspot')"

case "$is_on" in
  0) nmcli connection up Hotspot ;;
  1) nmcli connection down Hotspot ;;
  *) echo "Unexpected hotspot state: $is_on" >&2; exit 1 ;;
esac