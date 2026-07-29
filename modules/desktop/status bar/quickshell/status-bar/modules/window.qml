// Active window title: stretches to fill the gap between the left and right clusters.
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import ".."

Rectangle {
  id: root
  visible: Theme.showWindow

  property string title: "Window"

  Layout.fillWidth: true
  Layout.alignment: Qt.AlignVCenter
  implicitHeight: 22
  radius: 8
  color: Theme.colPanel
  border.color: Theme.colBorder
  border.width: Theme.borderWidth

  Text {
    anchors.fill: parent
    anchors.leftMargin: 10
    anchors.rightMargin: 10
    verticalAlignment: Text.AlignVCenter
    text: root.title
    color: Theme.colPurple
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
    elide: Text.ElideRight
    maximumLineCount: 1
  }

  Process {
    id: proc
    command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.title // empty'"]
    stdout: SplitParser {
      onRead: data => {
        if (data && data.trim()) root.title = data.trim()
      }
    }
    Component.onCompleted: running = true
  }

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
