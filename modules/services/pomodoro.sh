#!/usr/bin/env bash

tmp_file=/tmp/pomodoro.json
jq -n \
  --arg cycle_count 0 \
  --arg work 0 \
  --arg pause 0 \
  '{cycle_count:$cycle_count, work:$work, pause:$pause}' > $tmp_file

time_working=30min
time_pause=3min

# conversion
time_working=${time_working//[^0-9]/}                           # extract integer
time_pause=${time_pause//[^0-9]/}

now=$(date +%H%M)                                               # convert time H:M in number HM
if (( 10#$now >= 1200 && 10#$now <= 1330 )); then               # exit service between 12:00 and 13:30 pm
  echo "service terminated because current time between 12:00 and 13:30"
  exit 0
fi

# if the system has booted, reset cycle_count else continue for the next cycle
if journalctl --user -u pomodoro.service -n 2 | grep -i boot > /dev/null; then
  cycle_count=0
else
  cycle_count=$(jq -r '.cycle_count' $tmp_file)
fi

if [ "${cycle_count:-0}" -eq 3 ]; then                          # if cycle_count is unset/empty; substitute to 0 then compare if equal to 3
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

json=$(jq --arg v "$cycle_count" '.cycle_count = $v' $tmp_file)
echo $json > $tmp_file

echo "Running cycle $(jq -r '.cycle_count' $tmp_file)/3"

notify-send -t 5000 "Pomodoro is starting the cycle $cycle_count"

loop_minutes(){
  local time=$1
  local mode=$2

  if [ "$mode" == "work" ]; then             # if work then reset pause
    json=$(jq '.pause = "0"' $tmp_file)
    echo $json > $tmp_file
  else
    json=$(jq '.work = "0"' $tmp_file)
    echo $json > $tmp_file
  fi

  for ((minute=1; minute<=time; minute++)); do          # increment at every minute
    json=$(jq --arg k "$mode" --arg v "$minute" '.[$k] = $v' $tmp_file)
    echo $json > $tmp_file
    sleep 60
  done
}

loop_minutes $time_working work

if [ "$cycle_count" -lt 3 ]; then                       # if cycle 1 or 2 then turn off screen for 2 minutes
  notify-send -t 10000 -u critical "Breath and rest your eyes"
  sleep 10

  if playerctl status | rg -s Playing; then 
    playerctl pause
  fi

  ## KO hyprland issue: Couldn't commit output {}
  # hyprctl dispatch dpms off

  loop_minutes $time_pause pause

  # hyprctl dispatch dpms on

elif [ $cycle_count -eq 3 ]; then                       # if cycle 3 then keep the system suspended until a user action
  notify-send -t 5000 "Only $time_pause minutes left before suspend"

  loop_minutes $time_pause pause

  notify-send -t 10000 -u critical "Pomodoro" "Suspend in 10s\n Lève-toi et Bouge"
  sleep 10
  if playerctl status | rg -s Playing; then 
    playerctl pause
  fi
  systemctl suspend
fi
