import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showKernel

  property string version: "Linux"

  Text {
    text: root.version
    color: Theme.colRed
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    command: ["uname", "-r"]
    stdout: SplitParser {
      onRead: data => {
        if (data) root.version = data.trim()
      }
    }
    Component.onCompleted: running = true
  }
}
