pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  // Theme colors
  property color colBg:       "#1a1b26"
  property color colPanel:    "#aa24283b"
  property color colBorder:   "#00cd00"
  property int   borderWidth: 2
  property color colFg:       "#a9b1d6"
  property color colMuted:    "#444b6a"
  property color colCyan:     "#0db9d7"
  property color colPurple:   "#ad8ee6"
  property color colRed:      "#f7768e"
  property color colYellow:   "#e0af68"
  property color colBlue:     "#7aa2f7"

  // Font
  property string fontFamily: "Ubuntu Mono:style=Regular"
  property int fontSize: 18

  // Module visibility toggles (see IpcHandler in shell.qml)
  property bool showLogo:       false
  property bool showWorkspaces: true
  property bool showLayout:     false
  property bool showWindow:     false
  property bool showKernel:     false
  property bool showCpu:        true
  property bool showMem:        true
  property bool showDisk:       true
  property bool showVol:        true
  property bool showClock:      true
}
