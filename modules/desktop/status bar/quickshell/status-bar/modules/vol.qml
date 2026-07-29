import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showVol

  property int level: 0

  Text {
    text: "Vol: " + root.level + "%"
    color: Theme.colPurple
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    id: proc
    command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var match = data.match(/Volume:\s*([\d.]+)/)
        if (match) {
          root.level = Math.round(parseFloat(match[1]) * 100)
        }
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
