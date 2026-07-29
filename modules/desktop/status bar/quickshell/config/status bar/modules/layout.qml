import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showLayout

  property string layout: "Tile"

  Text {
    text: root.layout
    color: Theme.colFg
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    id: proc
    command: ["sh", "-c", "hyprctl activewindow -j | jq -r 'if .floating then \"Floating\" elif .fullscreen == 1 then \"Fullscreen\" else \"Tiled\" end'"]
    stdout: SplitParser {
      onRead: data => {
        if (data && data.trim()) root.layout = data.trim()
      }
    }
    Component.onCompleted: running = true
  }

  // Instant updates on Hyprland events, with a slow backup poll
  Connections {
    target: Hyprland
    function onRawEvent(event) { proc.running = true }
  }

  Timer {
    interval: 200
    running: true
    repeat: true
    onTriggered: proc.running = true
  }
}
