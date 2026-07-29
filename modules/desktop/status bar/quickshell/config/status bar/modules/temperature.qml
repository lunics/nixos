import Quickshell.Io
import QtQuick

import ".."

Pill {
  id: root
  visible: Theme.showTemp && root.present

  property bool present: false
  property int temp: 0

  // Thermometer glyph, tinted by how hot the CPU runs.
  function tempColor(t) {
    if (t >= 80) return Theme.colRed
    if (t >= 60) return Theme.colYellow
    return Theme.colFg
  }

  Text {
    text: String.fromCodePoint(0xF050F)  // mdi-thermometer
    color: root.tempColor(root.temp)
    font.pixelSize: Theme.fontSize
    font.family: "FiraCode Nerd Font"
    font.bold: true
  }

  Text {
    text: root.temp + "°C"
    color: Theme.colFg
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
  }

  Process {
    id: proc
    // Prefer the CPU package sensor (coretemp/k10temp), fall back to thermal zones.
    command: ["sh", "-c",
      "t=\"\"\n" +
      "for h in /sys/class/hwmon/hwmon*; do\n" +
      "  case \"$(cat \"$h/name\" 2>/dev/null)\" in\n" +
      "    coretemp|k10temp|zenpower)\n" +
      "      for f in \"$h\"/temp*_label; do\n" +
      "        [ -e \"$f\" ] || continue\n" +
      "        case \"$(cat \"$f\")\" in\n" +
      "          Tctl|Tdie|Package*) t=$(cat \"${f%_label}_input\" 2>/dev/null); break;;\n" +
      "        esac\n" +
      "      done\n" +
      "      [ -z \"$t\" ] && t=$(cat \"$h/temp1_input\" 2>/dev/null)\n" +
      "      break;;\n" +
      "  esac\n" +
      "done\n" +
      "[ -z \"$t\" ] && for z in /sys/class/thermal/thermal_zone*; do\n" +
      "  [ \"$(cat \"$z/type\" 2>/dev/null)\" = \"x86_pkg_temp\" ] && { t=$(cat \"$z/temp\" 2>/dev/null); break; }\n" +
      "done\n" +
      "[ -z \"$t\" ] && t=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)\n" +
      "[ -n \"$t\" ] && echo $((t/1000))\n"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var v = parseInt(data.trim())
        if (isNaN(v)) return
        root.present = true
        root.temp = v
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
