import QtQuick

import ".."

Pill {
  visible: Theme.showLogo
  hpad: 6

  Image {
    width: 18
    height: 18
    source: "file:///home/USER/.config/quickshell/icons/nixos.png"
    fillMode: Image.PreserveAspectFit
  }
}
