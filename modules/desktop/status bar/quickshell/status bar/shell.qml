import Quickshell
import Quickshell.Io
import QtQuick
import "modules" as Modules

ShellRoot {
  id: root

  // IPC control, e.g. `qs ipc call bar toggle cpu`
  // modules: logo, workspaces, layout, window, kernel, network, cpu, temperature, mem, disk, vol, battery, clock
  IpcHandler {
    target: "bar"

    function propFor(name: string): string {
      return "show" + name.charAt(0).toUpperCase() + name.slice(1)
    }
    function toggle(name: string) { var p = propFor(name); Theme[p] = !Theme[p] }
    function show(name: string) { Theme[propFor(name)] = true }
    function hide(name: string) { Theme[propFor(name)] = false }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      property var modelData
      screen: modelData

      anchors {
        bottom: true
        left:   true
        right:  true
      }

      implicitHeight: 30
      // Transparent bar: only the module frames are painted
      color: "transparent"

      margins {
        top: 0
        bottom: 0
        left: 0
        right: 0
      }

      // Workspaces stay on the left; every other module is stuck to the right
      Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 6
        spacing: 6

        Modules.Workspaces {}
      }

      // Clock centered horizontally, aligned with the other modules
      Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Modules.Clock {}
      }

      Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 6
        spacing: 6

        Modules.Vol {}
        Modules.Battery {}
        Modules.Network {}
        Modules.Temperature {}
        Modules.Cpu {}
        Modules.Mem {}
        Modules.Disk {}
        Modules.Logo {}
        Modules.Layout {}
        Modules.Window {}
        Modules.Kernel {}
      }
    }
  }
}
