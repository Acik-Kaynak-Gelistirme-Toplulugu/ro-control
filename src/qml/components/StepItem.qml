import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls

// StepItem — Single step in progress display
// Shows status: pending (○), running (⏳), done (✓), error (✗)

RowLayout {
    id: stepItem

    Layout.fillWidth: true
    spacing: 12

    property string text: ""
    property string status: "pending"  // pending | running | done | error
    property bool darkMode: false

    readonly property color statusColor: {
        switch (status) {
        case "done":
            return "#27ae60";
        case "running":
            return "#2980b9";
        case "error":
            return "#da4453";
        default:
            return palette.mid;
        }
    }

    readonly property string statusIcon: {
        switch (status) {
        case "done":
            return "✓";
        case "running":
            return "...";
        case "error":
            return "✗";
        default:
            return "○";
        }
    }

    Controls.Label {
        text: stepItem.statusIcon
        color: stepItem.statusColor
        font.pixelSize: 18
        Layout.alignment: Qt.AlignVCenter
    }

    // Text
    Controls.Label {
        text: stepItem.text
        opacity: stepItem.status === "done" ? 0.85 : (stepItem.status === "error" ? 1.0 : 0.9)
        color: stepItem.status === "error" ? stepItem.statusColor : (stepItem.darkMode ? "#eef3f9" : "#2d3136")
        font.family: "Monaco"
        font.pixelSize: 15
        Layout.fillWidth: true
    }

    Item {
        Layout.fillWidth: true
    }
}
