import Quickshell.Hyprland
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showWorkspaces
  hpad: 6

  // Hyprland now evaluates dispatch strings as Lua, so we call hl.dsp.focus directly.
  function goToWorkspace(id) {
    Hyprland.dispatch('hl.dsp.focus({ workspace = "' + id + '" })')
  }

  // Scroll to the next/previous existing workspace (dir: +1 / -1).
  function cycle(dir) {
    const ids = Hyprland.workspaces.values.map(w => w.id).sort((a, b) => a - b)
    if (ids.length === 0) return
    let idx = ids.indexOf(Hyprland.focusedWorkspace?.id ?? ids[0])
    if (idx === -1) idx = 0
    root.goToWorkspace(ids[(idx + dir + ids.length) % ids.length])
  }

  // Scroll to switch workspaces. Reparented onto root (not the Pill's inner Row)
  // so it doesn't shift the numbers, and Qt.NoButton so clicks still pass through.
  MouseArea {
    parent: root
    anchors.fill: root
    acceptedButtons: Qt.NoButton
    onWheel: (wheel) => root.cycle(wheel.angleDelta.y < 0 ? 1 : -1)
  }

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
        onClicked: root.goToWorkspace(modelData.id)
      }
    }
  }
}
