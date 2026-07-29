import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "modules" as Modules

ShellRoot {
  id: root

  // IPC control, e.g. `qs ipc call bar toggle cpu`
  // modules: logo, workspaces, layout, window, kernel, cpu, mem, disk, vol, clock
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

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 6
        anchors.rightMargin: 6
        spacing: 6

        Modules.Logo {}
        Modules.Workspaces {}
        Modules.Layout {}
        Modules.Window {}
        Modules.Kernel {}
        Modules.Cpu {}
        Modules.Mem {}
        Modules.Disk {}
        Modules.Vol {}
        Modules.Clock {}
      }
    }
  }
}
