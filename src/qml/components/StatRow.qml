import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls

// StatRow — Reusable metric row with label, progress bar, and value

RowLayout {
    id: statRow
    spacing: 12
    Layout.fillWidth: true

    property string label: ""
    property string value: ""
    property real fraction: 0.0  // 0.0 to 1.0
    property bool darkMode: false

    readonly property color barColor: "#2eb66d"

    Controls.Label {
        text: statRow.label
        opacity: 0.95
        color: statRow.darkMode ? "#eef3f9" : "#2d3136"
        font.pixelSize: 16
        Layout.preferredWidth: 90
    }

    Controls.ProgressBar {
        Layout.fillWidth: true
        from: 0.0
        to: 1.0
        value: statRow.fraction

        background: Rectangle {
            implicitHeight: 8
            radius: 4
            color: statRow.darkMode ? "#18212b" : "#dfe3e8"
        }

        contentItem: Item {
            implicitHeight: 8

            Rectangle {
                width: statRow.fraction * parent.width
                height: parent.height
                radius: 4
                color: statRow.barColor
            }
        }
    }

    Controls.Label {
        text: statRow.value
        font.pixelSize: 16
        opacity: 0.95
        color: statRow.darkMode ? "#aeb8c4" : "#77818b"
        Layout.preferredWidth: 80
        horizontalAlignment: Text.AlignRight
    }
}
