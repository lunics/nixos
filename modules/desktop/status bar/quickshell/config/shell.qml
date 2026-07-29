//@ pragma UseQApplication
// Umbrella root: a single Quickshell instance that mounts every feature.
// Add new features (widgets, notification center, ...) as sibling components here.
import Quickshell
import "status bar" as StatusBar

ShellRoot {
  StatusBar.Bar {}
}
