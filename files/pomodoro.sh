#!/usr/bin/env bash

## notif bureau courte + progress bar flotante persistante

minutes_working=45
reminder=5              # notification's timer before suspend system

notify-send -t 5000 "Pomodoro is starting"

sleep $(expr $minutes_working \* 60 / 2)
notify-send -t 5000 "Breath and rest your eyes"
sleep 5

hyprctl dispatch dpms off
sleep 120
hyprctl dispatch dpms on

sleep $(expr $minutes_working \* 60 / 2 - 3 \* 60)
notify-send "Only 3 minutes left before suspend"

sleep $(expr 3 \* 60) 
notify-send -t 10000 "Lève-toi et Bouge"
sleep 10

systemctl suspend
