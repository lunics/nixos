import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root
    property var popoutService: null

    pluginId: "pomodoro"

    // Only render the pill while the service is active (equivalent to the
    // `systemctl is-active` guard in pomodoro.sh).
    visibilityCommand: "systemctl --user is-active --quiet pomodoro.service"
    visibilityInterval: 5

    property string cycle: "1"
    property string work: "0"
    property string breakTime: "0"
    property bool   onBreak: false
    property string displayText: "🍅"

    function refresh() {
        Proc.runCommand("pomodoro.read", ["cat", "/tmp/pomodoro.json"], function (stdout, exitCode) {
            if (exitCode !== 0 || !stdout)
                return
            try {
                var d = JSON.parse(stdout)
                root.cycle     = String(d.cycle)
                root.work      = String(d.current_work)
                root.breakTime = String(d.break_time)
                root.onBreak   = (d.current_work === 0)
                root.displayText = "🍅 " + root.cycle + " : "
                    + (root.onBreak ? root.breakTime : root.work) + "m"
            } catch (e) {
            }
        }, 200)
    }

    Component.onCompleted: refresh()

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    horizontalBarPill: Component {
        StyledRect {
            width: label.implicitWidth + Theme.spacingM * 2
            height: parent.widgetThickness
            radius: Theme.cornerRadius
            color: root.onBreak ? Theme.primary : Theme.surfaceContainerHigh

            StyledText {
                id: label
                anchors.centerIn: parent
                text: root.displayText
                color: root.onBreak ? Theme.primaryText : Theme.surfaceText
                font.pixelSize: Theme.fontSizeMedium
            }
        }
    }

    verticalBarPill: Component {
        StyledRect {
            width: parent.widgetThickness
            height: label.implicitHeight + Theme.spacingM * 2
            radius: Theme.cornerRadius
            color: root.onBreak ? Theme.primary : Theme.surfaceContainerHigh

            StyledText {
                id: label
                anchors.centerIn: parent
                text: "🍅"
                color: root.onBreak ? Theme.primaryText : Theme.surfaceText
                font.pixelSize: Theme.fontSizeSmall
                rotation: 90
            }
        }
    }
}
