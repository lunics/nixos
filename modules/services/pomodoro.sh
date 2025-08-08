#!/usr/bin/env bash

## if pomodoro.timer stopped manually then echo "" > /tmp/pomodoro_cycle
# systemctl --user restart pomodoro.timer     # force reset the timer after every resume
# echo "pomodoro.timer restarted"

touch /tmp/pomodoro_cycle

time_working=30     # 30 min
time_screen_off=3   # 3 min
time_screen_off_sec=$(expr $time_screen_off \* 60)

now=$(date +%H%M)     # convert time H:M in number HM
if (( 10#$now >= 1200 && 10#$now <= 1330 )); then   # exit service between 12:00 and 13:30 pm
  echo "service exiting because current time between 12:00 and 13:30 pm"
  exit 0
fi

# if the system has booted reset the cycle_count else continue for the next cycle
if journalctl --user -u pomodoro.service -n 2 | grep -i boot > /dev/null; then
  cycle_count=0
else
  cycle_count=$(cat /tmp/pomodoro_cycle)
fi

if [ "${cycle_count:-0}" -eq 3 ]; then
  cycle_count=1

  ## add tmp file to remember if airpods was connected ?
  # try to reconnect airpods after the system suspend
  # if bluetoothctl devices | grep AirPods > /dev/null; then
  #   sleep 3
  #   if ! bluetoothctl devices Connected | grep AirPods; then
  #     bluetoothctl connect 90:5F:7A:BC:93:87
  #   fi
  # fi
else
  ((cycle_count++))
fi

echo $cycle_count > /tmp/pomodoro_cycle

echo "Running part $(cat /tmp/pomodoro_cycle)/3"

dunstify -t 5000 "Pomodoro is starting the cycle $cycle_count"

sleep $(expr $time_working \* 60)

if [ "$cycle_count" -lt 3 ]; then         # if cycle 1 or 2 then turn off screen for 2 minutes
  dunstify -t 10000 -u critical "Breath and rest your eyes"
  sleep 10

  if playerctl status | rg -s Playing; then 
    playerctl pause
  fi
  hyprctl dispatch dpms off
  sleep $time_screen_off_sec
  hyprctl dispatch dpms on

elif [ $cycle_count -eq 3 ]; then       # if cycle 3 then keep the system suspended until a user action
  dunstify -t 5000 "Only $time_screen_off_sec minutes left before suspend"
  sleep $time_screen_off_sec

  dunstify -t 10000 -u critical "Pomodoro" "Suspend in 10s\n Lève-toi et Bouge"
  sleep 10
  if playerctl status | rg -s Playing; then 
    playerctl pause
  fi
  systemctl suspend
fi
