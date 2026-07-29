import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showCpu

  property int usage: 0
  property var lastIdle: 0
  property var lastTotal: 0

  Text {
    text: "CPU: " + root.usage + "%"
    color: Theme.colYellow
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    id: proc
    command: ["sh", "-c", "head -1 /proc/stat"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var user = parseInt(parts[1]) || 0
        var nice = parseInt(parts[2]) || 0
        var system = parseInt(parts[3]) || 0
        var idle = parseInt(parts[4]) || 0
        var iowait = parseInt(parts[5]) || 0
        var irq = parseInt(parts[6]) || 0
        var softirq = parseInt(parts[7]) || 0

        var total = user + nice + system + idle + iowait + irq + softirq
        var idleTime = idle + iowait

        if (root.lastTotal > 0) {
          var totalDiff = total - root.lastTotal
          var idleDiff = idleTime - root.lastIdle
          if (totalDiff > 0) {
            root.usage = Math.round(100 * (totalDiff - idleDiff) / totalDiff)
          }
        }
        root.lastTotal = total
        root.lastIdle = idleTime
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
