// Rounded, glassy frame wrapping a single module's content.
// Children are laid out horizontally inside the frame.
import QtQuick
import QtQuick.Layouts

Rectangle {
  default property alias content: pillRow.data
  property int hpad: 10

  Layout.alignment: Qt.AlignVCenter
  implicitHeight: 22
  implicitWidth: pillRow.implicitWidth + hpad * 2
  radius: 8
  color: Theme.colPanel
  border.color: Theme.colBorder
  border.width: Theme.borderWidth

  Row {
    id: pillRow
    anchors.centerIn: parent
    spacing: 6
  }
}
