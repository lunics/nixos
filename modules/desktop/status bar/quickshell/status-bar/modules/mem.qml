import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showMem

  property int usage: 0

  Text {
    text: "Mem: " + root.usage + "%"
    color: Theme.colCyan
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    id: proc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        root.usage = Math.round(100 * used / total)
      }
    }
    Component.onCompleted: running = true
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: proc.running = true
  }
}
