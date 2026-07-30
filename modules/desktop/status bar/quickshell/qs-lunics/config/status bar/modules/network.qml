import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showNetwork

  property string kind: "none"   // "wifi" | "lan" | "none"
  property string label: ""      // SSID for wifi, interface for lan
  property int signal: 100       // wifi signal %, derived from /proc/net/wireless

  // Nerd Font glyphs (Material Design Icons).
  function icon(k) {
    if (k === "wifi") return String.fromCodePoint(0xF05A9)  // wifi
    if (k === "lan")  return String.fromCodePoint(0xF0200)  // ethernet
    return String.fromCodePoint(0xF0319)                    // lan-disconnect
  }

  function iconColor(k) {
    if (k === "lan")  return Theme.colBlue
    if (k !== "wifi") return Theme.colMuted
    // wifi: tint the icon by signal strength
    if (root.signal >= 70) return Theme.colGreen
    if (root.signal >= 50) return Theme.colBlue
    if (root.signal >= 25) return Theme.colYellow
    return Theme.colRed
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
    // Resolve the default-route interface, decide wifi vs lan, grab SSID + signal.
    command: ["sh", "-c",
      "dev=$(ip route show default 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i==\"dev\"){print $(i+1); exit}}'); " +
      "[ -z \"$dev\" ] && { printf 'none||\\n'; exit; }; " +
      "if [ -d \"/sys/class/net/$dev/wireless\" ]; then " +
      "ssid=$(iwctl station \"$dev\" show 2>/dev/null | sed -n 's/.*Connected network[[:space:]]\\{2,\\}//p' | sed 's/[[:space:]]*$//'); " +
      // link quality is reported out of 70 in /proc/net/wireless; scale to a percent
      "sig=$(awk -v d=\"$dev:\" '$1==d{q=$3; sub(/[.]/,\"\",q); p=q/70*100; printf \"%d\", (p>100?100:p)}' /proc/net/wireless 2>/dev/null); " +
      "printf 'wifi|%s|%s\\n' \"$ssid\" \"$sig\"; " +
      "else printf 'lan|%s|\\n' \"$dev\"; fi"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split("|")
        root.kind = parts[0] || "none"
        root.label = parts.length > 1 ? parts[1] : ""
        root.signal = (parts.length > 2 && parts[2] !== "") ? parseInt(parts[2]) : 100
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
