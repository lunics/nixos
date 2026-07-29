import Quickshell.Hyprland
import QtQuick

import ".."

Pill {
  visible: Theme.showWorkspaces
  hpad: 6

  Repeater {
    model: 9

    Rectangle {
      width: 20
      height: 22
      color: "transparent"

      property var workspace: Hyprland.workspaces.values.find(ws => ws.id === index + 1) ?? null
      property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
      property bool hasWindows: workspace !== null

      Text {
        text: index + 1
        color: parent.isActive ? Theme.colCyan : (parent.hasWindows ? Theme.colCyan : Theme.colMuted)
        font.pixelSize: Theme.fontSize
        font.family: Theme.fontFamily
        font.bold: true
        anchors.centerIn: parent
      }

      Rectangle {
        width: 16
        height: 3
        radius: 1.5
        color: parent.isActive ? Theme.colPurple : "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
      }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + (index + 1))
      }
    }
  }
}
