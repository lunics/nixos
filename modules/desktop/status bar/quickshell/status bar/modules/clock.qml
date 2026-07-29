import QtQuick

import ".."

Pill {
  visible: Theme.showClock

  Text {
    id: clockText
    text: Qt.formatDateTime(new Date(), "HH:mm")
    color: Theme.colCyan
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm")
    }
  }
}
