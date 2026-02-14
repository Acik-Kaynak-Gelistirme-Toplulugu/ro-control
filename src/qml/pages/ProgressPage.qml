import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import "../components"
import io.github.AcikKaynakGelistirmeToplulugu.rocontrol

// Progress Page — Real-time installation/removal progress
// Shows step-by-step process with status icons

Item {
    id: progressPage

    required property var controller
    required property bool darkMode
    signal finished

    readonly property color textColor: darkMode ? "#eef3f9" : "#2d3136"
    readonly property color mutedColor: darkMode ? "#aeb8c4" : "#77818b"

    Controls.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            width: Math.min(parent.width, 660)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            Item {
                Layout.preferredHeight: 40
            }

            // ─── Title ───
            Controls.Label {
                text: controller.current_status === "removing" ? qsTr("Removing Drivers...") : qsTr("Installing nvidia-%1").arg(controller.best_version)
                font.pixelSize: 42
                font.weight: Font.DemiBold
                Layout.alignment: Qt.AlignHCenter
                color: textColor
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 16

                Controls.ProgressBar {
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: controller.install_progress
                    indeterminate: controller.install_progress === 0 && controller.is_installing
                }

                Controls.Label {
                    text: controller.install_progress + "%"
                    opacity: 0.8
                    font.pixelSize: 28
                    font.weight: Font.DemiBold
                    color: mutedColor
                    Layout.preferredWidth: 62
                    horizontalAlignment: Text.AlignRight
                }
            }

            // ─── Installation Steps ───
            Controls.GroupBox {
                visible: controller.is_installing
                Layout.fillWidth: true
                title: qsTr("Installation Steps")

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 4

                    StepItem {
                        text: qsTr("Checking compatibility")
                        status: controller.install_progress >= 10 ? "done" : "pending"
                        darkMode: progressPage.darkMode
                    }

                    StepItem {
                        text: qsTr("Downloading packages")
                        status: controller.install_progress >= 30 ? "done" : controller.install_progress >= 10 ? "running" : "pending"
                        darkMode: progressPage.darkMode
                    }

                    StepItem {
                        text: qsTr("Installing drivers")
                        status: controller.install_progress >= 60 ? "done" : controller.install_progress >= 30 ? "running" : "pending"
                        darkMode: progressPage.darkMode
                    }

                    StepItem {
                        text: qsTr("Building kernel module")
                        status: controller.install_progress >= 80 ? "done" : controller.install_progress >= 60 ? "running" : "pending"
                        darkMode: progressPage.darkMode
                    }

                    StepItem {
                        text: qsTr("Running dracut")
                        status: controller.install_progress >= 100 ? "done" : controller.install_progress >= 80 ? "running" : "pending"
                        darkMode: progressPage.darkMode
                    }
                }
            }

            // ─── Log Output ───
            Controls.GroupBox {
                Layout.fillWidth: true
                Layout.preferredHeight: 240
                title: qsTr("Log")

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    StepItem {
                        text: qsTr("Checking compatibility...")
                        status: controller.install_progress >= 10 ? "done" : "pending"
                        darkMode: progressPage.darkMode
                    }

                    StepItem {
                        text: qsTr("Downloading packages...")
                        status: controller.install_progress >= 30 ? "done" : controller.install_progress >= 10 ? "running" : "pending"
                        darkMode: progressPage.darkMode
                    }

                    StepItem {
                        text: qsTr("Installing akmod-nvidia...")
                        status: controller.install_progress >= 60 ? "done" : controller.install_progress >= 30 ? "running" : "pending"
                        darkMode: progressPage.darkMode
                    }

                    StepItem {
                        text: qsTr("Building kernel module...")
                        status: controller.install_progress >= 80 ? "done" : controller.install_progress >= 60 ? "running" : "pending"
                        darkMode: progressPage.darkMode
                    }

                    StepItem {
                        text: qsTr("Running dracut...")
                        status: controller.install_progress >= 100 ? "done" : controller.install_progress >= 80 ? "running" : "pending"
                        darkMode: progressPage.darkMode
                    }
                }
            }

            Rectangle {
                visible: controller.is_installing
                Layout.fillWidth: true
                implicitHeight: 58
                radius: 8
                color: darkMode ? "#3a2e1f" : "#fef4e8"
                border.width: 1
                border.color: "#f59f23"

                Controls.Label {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    text: qsTr("! Do not turn off your computer")
                    color: "#f59f23"
                    font.pixelSize: 16
                    font.weight: Font.DemiBold
                }
            }

            // ─── Buttons ───
            RowLayout {
                Layout.fillWidth: true
                spacing: 0

                Controls.Button {
                    visible: controller.is_installing
                    text: qsTr("Cancel")
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 100
                    onClicked: cancelDialog.open()
                }

                Controls.Button {
                    visible: !controller.is_installing
                    text: qsTr("Done")
                    highlighted: true
                    Layout.fillWidth: true
                    onClicked: progressPage.finished()
                }

                Controls.Button {
                    visible: !controller.is_installing && controller.install_progress >= 100
                    text: qsTr("Reboot Now")
                    icon.name: "system-reboot"
                    highlighted: true
                    Layout.fillWidth: true
                }
            }

            Item {
                Layout.preferredHeight: 20
            }
        }
    }

    // ─── Cancel Confirmation Dialog ───
    Controls.Dialog {
        id: cancelDialog
        title: qsTr("Cancel Installation?")
        modal: true
        anchors.centerIn: parent
        standardButtons: Controls.Dialog.Yes | Controls.Dialog.No

        Controls.Label {
            text: qsTr("Cancelling may leave your system in an incomplete state.\nAre you sure?")
            wrapMode: Text.WordWrap
        }

        onAccepted: {
            // TODO: implement cancel logic
            progressPage.finished();
        }
    }
}
