#!/usr/bin/env bash

cycle=$(cat /tmp/pomodoro_cycle)

if systemctl --user is-active --quiet pomodoro.service; then
  echo '{"message":"🍅  '$cycle'"}'
fi
