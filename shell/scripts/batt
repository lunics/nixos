#!/bin/env bash

## loop until 100% then reset
  # setcharge 80 81 BAT0    # reset BAT1 to default settings to stop BAT1 charging over 81%

if [ -z $# ] || [ "$1" = "list" ]; then            # IF no args or arg1 = list THEN show battery level
  for file in $(ls /sys/class/power_supply/BAT*); do
    # cat /sys/class/power_supply/BAT?/capacity     ## old a delete
    echo "$file : $(cat /sys/class/power_supply/$file/capacity)"
  done
elif [ "$1" = "charge" ]; then
    echo "charger à 85%"
elif [ "$1" = "full_charge" ]; then
  echo charging BAT1 until 95%
  # sudo tlp fullcharge BAT1
  sudo tlp setcharge 94 95 BAT1 # force full charge of removable battery
else
  charge the current BAT charging||discharging (the active one)
  echo charging $1 until 95%
  sudo tlp setcharge 94 95 $1
fi
