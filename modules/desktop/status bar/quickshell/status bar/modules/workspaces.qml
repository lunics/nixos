import Quickshell.Hyprland
import QtQuick

import ".."

Pill {
  visible: Theme.showWorkspaces
  hpad: 6

  Repeater {
    model: Hyprland.workspaces

    Rectangle {
      required property var modelData

      width: 20
      height: 22
      color: "transparent"

      property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id

      Text {
        text: modelData.id
        color: parent.isActive ? Theme.colCyan : Theme.colMuted
        font.pixelSize: Theme.fontSize
        font.family: Theme.fontFamily
        font.bold: true
        anchors.centerIn: parent
      }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + modelData.id)
      }
    }
  }
}
