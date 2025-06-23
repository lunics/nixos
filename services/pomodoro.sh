#!/usr/bin/env bash

## if pomodoro.timer stopped manually then echo "" > /tmp/pomodoro_cycle

touch /tmp/pomodoro_cycle

time_working=30     # 30 min
time_screen_off=3   # 3 min
time_screen_off_sec=$(expr $time_screen_off \* 60)

# if the system has booted reset the cycle_count else continue for the next cycle
if journalctl --user -u pomodoro.service -n 2 | grep -i boot > /dev/null; then
  cycle_count=0
else
  cycle_count=$(cat /tmp/pomodoro_cycle)
fi

if [ $cycle_count -eq 3 ]; then
  cycle_count=1

  # try to reconnect airpods after the system suspend
  if bluetoothctl devices | grep AirPods; then
    sleep 3
    if ! bluetoothctl devices Connected | grep AirPods; then
      bluetoothctl connect 90:5F:7A:BC:93:87
    fi
  fi
else
  ((cycle_count++))
fi

echo $cycle_count > /tmp/pomodoro_cycle

dunstify -t 5000 "Pomodoro is starting the cycle $cycle_count"

sleep $(expr $time_working \* 60)

if [ $cycle_count -lt 3 ]; then                     # if cycle 1 or 2 then turn off screen for 2 minutes
  dunstify -t 5000 "Breath and rest your eyes"
  sleep 5

  playerctl pause
  hyprctl dispatch dpms off
  sleep $time_screen_off_sec
  hyprctl dispatch dpms on
  playerctl play

elif [ $cycle_count -eq 3 ]; then                   # if cycle 3 then keep the system suspended until a user action
  dunstify "Only $time_screen_off_sec minutes left before suspend"
  sleep $time_screen_off_sec

  dunstify -t 10000 "Lève-toi et Bouge"
  sleep 10
  systemctl suspend
fi
