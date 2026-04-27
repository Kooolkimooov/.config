#!/bin/sh

# Show hotspot state from active NetworkManager connections.
if ! command -v nmcli >/dev/null 2>&1; then
  echo "󰖪 N/A"
  exit 0
fi

active_wifi_conn=$(nmcli -t -f NAME,TYPE connection show --active 2>/dev/null | awk -F: '$2=="802-11-wireless"{print $1; exit}')

if [ -z "$active_wifi_conn" ]; then
  echo "󰖪 Off"
  exit 0
fi

mode=$(nmcli -g 802-11-wireless.mode connection show "$active_wifi_conn" 2>/dev/null | head -n1)
ssid=$(nmcli -g 802-11-wireless.ssid connection show "$active_wifi_conn" 2>/dev/null | head -n1)

if [ "$mode" = "ap" ]; then
  if [ -n "$ssid" ]; then
    echo "󰖩 ${ssid}"
  else
    echo "󰖩 On"
  fi
else
  echo "󰖪 Off"
fi