import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showNetwork

  property string kind: "none"   // "wifi" | "lan" | "none"
  property string label: ""      // SSID for wifi, interface for lan

  // Nerd Font glyphs (Material Design Icons).
  function icon(k) {
    if (k === "wifi") return String.fromCodePoint(0xF05A9)  // wifi
    if (k === "lan")  return String.fromCodePoint(0xF0200)  // ethernet
    return String.fromCodePoint(0xF0319)                    // lan-disconnect
  }

  function iconColor(k) {
    if (k === "wifi") return Theme.colCyan
    if (k === "lan")  return Theme.colBlue
    return Theme.colMuted
  }

  Text {
    text: root.icon(root.kind)
    color: root.iconColor(root.kind)
    font.pixelSize: Theme.fontSize
    font.family: "FiraCode Nerd Font"
    font.bold: true
  }

  Text {
    visible: root.label !== ""
    text: root.label
    color: Theme.colFg
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    id: proc
    // Resolve the default-route interface, decide wifi vs lan, grab the SSID.
    command: ["sh", "-c",
      "dev=$(ip route show default 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i==\"dev\"){print $(i+1); exit}}'); " +
      "[ -z \"$dev\" ] && { printf 'none|\\n'; exit; }; " +
      "if [ -d \"/sys/class/net/$dev/wireless\" ]; then " +
      "ssid=$(iwctl station \"$dev\" show 2>/dev/null | sed -n 's/.*Connected network[[:space:]]\\{2,\\}//p' | sed 's/[[:space:]]*$//'); " +
      "printf 'wifi|%s\\n' \"$ssid\"; " +
      "else printf 'lan|%s\\n' \"$dev\"; fi"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split("|")
        root.kind = parts[0] || "none"
        root.label = parts.length > 1 ? parts[1] : ""
      }
    }
    Component.onCompleted: running = true
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: proc.running = true
  }
}
