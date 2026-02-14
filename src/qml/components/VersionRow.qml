import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls

// VersionRow — Shows a driver version with selection and compatibility status
// Used in Expert page for version selection

Rectangle {
    id: versionRow

    implicitHeight: 54
    radius: 6

    Layout.fillWidth: true

    property string version: ""
    property string status: "available"  // available | installed | selected | incompatible
    property string statusText: ""
    property bool selected: false
    property bool darkMode: false

    color: mouseArea.containsMouse ? (versionRow.darkMode ? "#313d4d" : "#eef1f4") : "transparent"

    Behavior on color {
        ColorAnimation {
            duration: 150
        }
    }

    signal clicked

    border.width: 0

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: versionRow.clicked()
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // Radio button or checkmark
        Rectangle {
            width: 18
            height: 18
            radius: 9
            color: "transparent"
            border.width: 2
            border.color: versionRow.selected ? "#35a3df" : (versionRow.darkMode ? "#9eadbf" : "#77818b")

            Controls.Label {
                anchors.centerIn: parent
                text: versionRow.selected ? "●" : ""
                color: "#35a3df"
                font.bold: true
                font.pixelSize: 9
            }
        }

        // Version text
        ColumnLayout {
            spacing: 1
            Layout.fillWidth: true

            Controls.Label {
                text: versionRow.version
                font.bold: true
                font.pixelSize: 16
                color: versionRow.darkMode ? "#eef3f9" : "#2d3136"
            }

            Controls.Label {
                text: versionRow.statusText
                font.pixelSize: 14
                opacity: 0.9
                color: versionRow.darkMode ? "#aeb8c4" : "#77818b"
            }
        }

        Controls.Label {
            text: "◉"
            color: "#2eb66d"
            font.pixelSize: 18
            visible: versionRow.status !== "incompatible"
        }
    }
}
