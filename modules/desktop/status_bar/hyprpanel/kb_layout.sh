#!/usr/bin/env bash

source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

kb_layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .layout')

if [ "$kb_layout" == "us" ]; then
  echo '{"message":"'$kb_layout'"}'
fi
