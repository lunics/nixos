#!/usr/bin/env bash

## USELESS, still losing after x2: pkill Hyrpland
# dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

alacritty &
firefox   &
freetube  &
spotify   &
discord   &
udiskie   &
