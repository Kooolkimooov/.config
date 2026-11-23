#!/bin/sh
# Login entry for the Nix (Home Manager) Hyprland, started by
# /usr/local/share/wayland-sessions/hyprland-nix.desktop.
# Loads the Home Manager environment (PATH with ~/.nix-profile/bin, XDG_DATA_DIRS for
# menus/icons of Nix apps, cursors, locales), then runs Hyprland's launcher.
hm_vars="$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
[ -r "$hm_vars" ] && . "$hm_vars"
exec "$HOME/.nix-profile/bin/start-hyprland" "$@"
