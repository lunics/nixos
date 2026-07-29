import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  // Hidden when no battery is present (e.g. desktop), even if toggled on.
  visible: Theme.showBattery && root.present

  property bool present: false
  property string status: "Unknown"
  property int level: 0

  // Nerd Font glyphs (Material Design Icons): charging / on-battery / AC bypass.
  function icon(s) {
    if (s === "Charging")    return String.fromCodePoint(0xF0084)  // battery-charging
    if (s === "Discharging") return String.fromCodePoint(0xF0079)  // battery
    return String.fromCodePoint(0xF06A5)                           // power-plug (Not charging / Full)
  }

  function iconColor(s) {
    if (s === "Charging")    return Theme.colBlue
    if (s === "Discharging") return root.level <= 20 ? Theme.colRed : Theme.colFg
    return Theme.colCyan
  }

  Text {
    text: root.icon(root.status)
    color: root.iconColor(root.status)
    font.pixelSize: Theme.fontSize
    font.family: "FiraCode Nerd Font"
    font.bold: true
  }

  Text {
    text: root.level + "%"
    color: Theme.colFg
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    id: proc
    // '|' separator because some statuses contain a space ("Not charging").
    command: ["sh", "-c", "for b in /sys/class/power_supply/BAT*; do [ -d \"$b\" ] || continue; printf '%s|%s\\n' \"$(cat \"$b/status\")\" \"$(cat \"$b/capacity\")\"; break; done"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split("|")
        if (parts.length < 2) return
        root.present = true
        root.status = parts[0]
        root.level = parseInt(parts[1]) || 0
      }
    }
    Component.onCompleted: running = true
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: proc.running = true
  }
}
