import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ShellRoot {
  id: root

  // Theme colors
  property color colBg: "#1a1b26"
  property color colPanel: "#aa24283b"
  property color colBorder: "#9ece6a"
  property int borderWidth: 1
  property color colFg: "#a9b1d6"
  property color colMuted: "#444b6a"
  property color colCyan: "#0db9d7"
  property color colPurple: "#ad8ee6"
  property color colRed: "#f7768e"
  property color colYellow: "#e0af68"
  property color colBlue: "#7aa2f7"

  // Font
  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 14

  // System info properties
  property string kernelVersion: "Linux"
  property int cpuUsage: 0
  property int memUsage: 0
  property int diskUsage: 0
  property int volumeLevel: 0
  property string activeWindow: "Window"
  property string currentLayout: "Tile"

  // Module visibility toggles
  property bool showLogo: false
  property bool showWorkspaces: true
  property bool showLayout: true
  property bool showWindow: false
  property bool showKernel: false
  property bool showCpu: true
  property bool showMem: true
  property bool showDisk: true
  property bool showVol: true
  property bool showClock: true

  // CPU tracking
  property var lastCpuIdle: 0
  property var lastCpuTotal: 0

  // Kernel version
  Process {
    id: kernelProc
    command: ["uname", "-r"]
    stdout: SplitParser {
      onRead: data => {
        if (data) kernelVersion = data.trim()
      }
    }
    Component.onCompleted: running = true
  }

  // CPU usage
  Process {
    id: cpuProc
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

        if (lastCpuTotal > 0) {
          var totalDiff = total - lastCpuTotal
          var idleDiff = idleTime - lastCpuIdle
          if (totalDiff > 0) {
            cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff)
          }
        }
        lastCpuTotal = total
        lastCpuIdle = idleTime
      }
    }
    Component.onCompleted: running = true
  }

  // Memory usage
  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        memUsage = Math.round(100 * used / total)
      }
    }
    Component.onCompleted: running = true
  }

  // Disk usage
  Process {
    id: diskProc
    command: ["sh", "-c", "df / | tail -1"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var percentStr = parts[4] || "0%"
        diskUsage = parseInt(percentStr.replace('%', '')) || 0
      }
    }
    Component.onCompleted: running = true
  }

  // Volume level (wpctl for PipeWire)
  Process {
    id: volProc
    command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var match = data.match(/Volume:\s*([\d.]+)/)
        if (match) {
          volumeLevel = Math.round(parseFloat(match[1]) * 100)
        }
      }
    }
    Component.onCompleted: running = true
  }

  // Active window title
  Process {
    id: windowProc
    command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.title // empty'"]
    stdout: SplitParser {
      onRead: data => {
        if (data && data.trim()) {
          activeWindow = data.trim()
        }
      }
    }
    Component.onCompleted: running = true
  }

  // Current layout (Hyprland: dwindle/master/floating)
  Process {
    id: layoutProc
    command: ["sh", "-c", "hyprctl activewindow -j | jq -r 'if .floating then \"Floating\" elif .fullscreen == 1 then \"Fullscreen\" else \"Tiled\" end'"]
    stdout: SplitParser {
      onRead: data => {
        if (data && data.trim()) {
          currentLayout = data.trim()
        }
      }
    }
    Component.onCompleted: running = true
  }

  // IPC control, e.g. `qs ipc call bar toggle cpu`
  // modules: logo, workspaces, layout, window, kernel, cpu, mem, disk, vol, clock
  IpcHandler {
    target: "bar"

    function propFor(name: string): string {
      return "show" + name.charAt(0).toUpperCase() + name.slice(1)
    }
    function toggle(name: string) { var p = propFor(name); root[p] = !root[p] }
    function show(name: string) { root[propFor(name)] = true }
    function hide(name: string) { root[propFor(name)] = false }
  }

  // Slow timer for system stats
  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      cpuProc.running = true
      memProc.running = true
      diskProc.running = true
      volProc.running = true
    }
  }

  // Event-based updates for window/layout (instant)
  Connections {
    target: Hyprland
    function onRawEvent(event) {
      windowProc.running = true
      layoutProc.running = true
    }
  }

  // Backup timer for window/layout (catches edge cases)
  Timer {
    interval: 200
    running: true
    repeat: true
    onTriggered: {
      windowProc.running = true
      layoutProc.running = true
    }
  }

  // Rounded frame wrapping a single module's content.
  // Children are laid out horizontally inside the frame.
  component Pill: Rectangle {
    default property alias content: pillRow.data
    property int hpad: 10

    Layout.alignment: Qt.AlignVCenter
    implicitHeight: 22
    implicitWidth: pillRow.implicitWidth + hpad * 2
    radius: 8
    color: root.colPanel
    border.color: root.colBorder
    border.width: root.borderWidth

    Row {
      id: pillRow
      anchors.centerIn: parent
      spacing: 6
    }
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

        // Logo
        Pill {
          visible: root.showLogo
          hpad: 6

          Image {
            width: 18
            height: 18
            source: "file:///home/USER/.config/quickshell/icons/nixos.png"
            fillMode: Image.PreserveAspectFit
          }
        }

        // Workspaces
        Pill {
          visible: root.showWorkspaces
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
                color: parent.isActive ? root.colCyan : (parent.hasWindows ? root.colCyan : root.colMuted)
                font.pixelSize: root.fontSize
                font.family: root.fontFamily
                font.bold: true
                anchors.centerIn: parent
              }

              Rectangle {
                width: 16
                height: 3
                radius: 1.5
                color: parent.isActive ? root.colPurple : "transparent"
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

        // Layout
        Pill {
          visible: root.showLayout

          Text {
            text: currentLayout
            color: root.colFg
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            font.bold: true
          }
        }

        // Active window title: stretches to fill the gap between the left and right clusters
        Rectangle {
          visible: root.showWindow
          Layout.fillWidth: true
          Layout.alignment: Qt.AlignVCenter
          implicitHeight: 22
          radius: 8
          color: root.colPanel
          border.color: root.colBorder
          border.width: root.borderWidth

          Text {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            verticalAlignment: Text.AlignVCenter
            text: activeWindow
            color: root.colPurple
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            font.bold: true
            elide: Text.ElideRight
            maximumLineCount: 1
          }
        }

        // Kernel
        Pill {
          visible: root.showKernel

          Text {
            text: kernelVersion
            color: root.colRed
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            font.bold: true
          }
        }

        // CPU
        Pill {
          visible: root.showCpu

          Text {
            text: "CPU: " + cpuUsage + "%"
            color: root.colYellow
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            font.bold: true
          }
        }

        // Memory
        Pill {
          visible: root.showMem

          Text {
            text: "Mem: " + memUsage + "%"
            color: root.colCyan
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            font.bold: true
          }
        }

        // Disk
        Pill {
          visible: root.showDisk

          Text {
            text: "Disk: " + diskUsage + "%"
            color: root.colBlue
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            font.bold: true
          }
        }

        // Volume
        Pill {
          visible: root.showVol

          Text {
            text: "Vol: " + volumeLevel + "%"
            color: root.colPurple
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            font.bold: true
          }
        }

        // Clock
        Pill {
          visible: root.showClock

          Text {
            id: clockText
            text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
            color: root.colCyan
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            font.bold: true

            Timer {
              interval: 1000
              running: true
              repeat: true
              onTriggered: clockText.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
            }
          }
        }
      }
    }
  }
}
