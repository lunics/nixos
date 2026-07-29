import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showDisk

  property int usage: 0

  Text {
    text: "Disk: " + root.usage + "%"
    color: Theme.colBlue
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    id: proc
    command: ["sh", "-c", "df / | tail -1"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var percentStr = parts[4] || "0%"
        root.usage = parseInt(percentStr.replace('%', '')) || 0
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
