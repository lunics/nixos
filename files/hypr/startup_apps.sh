#!/usr/bin/env bash

## still losing WM after x2: pkill Hyrpland
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# needed for firefox screen sharing under wayland
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

alacritty &
firefox   &
# freetube  &
# spotify   &
# discord   &
udiskie   &
