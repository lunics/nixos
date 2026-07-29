import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import ".."

// Hosts the icons of every open program that exposes a StatusNotifierItem.
Pill {
  id: root
  // Nothing to frame when the tray is empty.
  visible: Theme.showSystray && SystemTray.items.values.length > 0
  hpad: 6

  Repeater {
    model: SystemTray.items

    Item {
      id: entry
      required property var modelData

      width: 18
      height: 18

      IconImage {
        anchors.fill: parent
        source: entry.modelData.icon
        asynchronous: true
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onClicked: (mouse) => {
          if (mouse.button === Qt.LeftButton) {
            // Some items only offer a menu (no primary action).
            if (entry.modelData.onlyMenu) menuAnchor.open()
            else entry.modelData.activate()
          } else if (mouse.button === Qt.MiddleButton) {
            entry.modelData.secondaryActivate()
          } else if (mouse.button === Qt.RightButton) {
            menuAnchor.open()
          }
        }
        onWheel: (wheel) => entry.modelData.scroll(wheel.angleDelta.y, false)
      }

      // Context menu, opened above the bar (the bar sits at the bottom).
      QsMenuAnchor {
        id: menuAnchor
        menu: entry.modelData.menu
        anchor.item: entry
        anchor.edges: Edges.Top
        anchor.gravity: Edges.Top
      }
    }
  }
}
