import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import "../components"
import io.github.AcikKaynakGelistirmeToplulugu.rocontrol

// Install Page — Express & Custom install options
// States: default, update available, up to date, no internet, secure boot

Item {
    id: installPage

    required property var controller
    required property bool darkMode
    signal showExpert
    signal showProgress

    readonly property color textColor: darkMode ? "#eef3f9" : "#2d3136"
    readonly property color mutedColor: darkMode ? "#aeb8c4" : "#77818b"
    readonly property color cardColor: darkMode ? "#2a333f" : "#f5f6f8"
    readonly property color borderColor: darkMode ? "#3b4655" : "#c8ced6"

    Controls.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            width: Math.min(parent.width, 660)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            Item {
                Layout.preferredHeight: 24
            }

            // ─── Hero Section ───
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Rectangle {
                    width: 58
                    height: 58
                    radius: 29
                    color: darkMode ? "#173447" : "#d8edf7"
                    Layout.alignment: Qt.AlignHCenter

                    Controls.Label {
                        anchors.centerIn: parent
                        text: "~"
                        font.pixelSize: 30
                        color: "#30a6e0"
                    }
                }

                Controls.Label {
                    text: qsTr("Select Installation Type")
                    font.pixelSize: 40
                    font.weight: Font.DemiBold
                    Layout.alignment: Qt.AlignHCenter
                    color: textColor
                }

                Controls.Label {
                    text: qsTr("Optimized options for your hardware")
                    opacity: 0.8
                    font.pixelSize: 16
                    color: mutedColor
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            Item {
                Layout.preferredHeight: 14
            }

            // ─── No Internet Warning ───
            WarningBanner {
                visible: !controller.has_internet
                type: "warning"
                text: qsTr("Internet connection required for driver download")
                Layout.fillWidth: true
            }

            // ─── Secure Boot Warning ───
            WarningBanner {
                visible: controller.secure_boot
                type: "error"
                text: qsTr("Secure Boot is enabled — unsigned drivers may not work. Disable it in UEFI to proceed.")
                Layout.fillWidth: true
            }

            // ─── Express Install Card ───
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 116
                radius: 8
                color: cardColor
                border.width: 1
                border.color: borderColor

                MouseArea {
                    anchors.fill: parent
                    enabled: controller.has_internet
                    cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: installPage.showProgress()
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 18
                    spacing: 14

                    Controls.Label {
                        text: "✓"
                        color: "#2eb66d"
                        font.pixelSize: 28
                        Layout.alignment: Qt.AlignTop
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6

                        Controls.Label {
                            text: qsTr("Express Install (Recommended)")
                            font.pixelSize: 16
                            font.weight: Font.DemiBold
                            color: textColor
                        }

                        Controls.Label {
                            text: qsTr("Installs nvidia-%1").arg(controller.best_version.length > 0 ? controller.best_version : "560.35.03")
                            color: mutedColor
                            font.pixelSize: 14
                        }

                        Controls.Label {
                            text: qsTr("Compatible: Verified")
                            color: "#2eb66d"
                            font.pixelSize: 14
                            font.weight: Font.DemiBold
                        }
                    }
                }
            }

            // ─── Custom Install Card ───
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 98
                radius: 8
                color: cardColor
                border.width: 1
                border.color: borderColor

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: installPage.showExpert()
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 18
                    spacing: 14

                    Controls.Label {
                        text: "⚙"
                        color: "#35a3df"
                        font.pixelSize: 25
                        Layout.alignment: Qt.AlignTop
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6

                        Controls.Label {
                            text: qsTr("Custom Install (Expert)")
                            font.pixelSize: 16
                            font.weight: Font.DemiBold
                            color: textColor
                        }

                        Controls.Label {
                            text: qsTr("Choose version, kernel module")
                            color: mutedColor
                            font.pixelSize: 14
                        }
                    }
                }
            }

            Rectangle {
                visible: controller.secure_boot
                Layout.fillWidth: true
                implicitHeight: 96
                radius: 8
                color: darkMode ? "#3a2e1f" : "#fef4e8"
                border.width: 1
                border.color: "#f59f23"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 6

                    Controls.Label {
                        text: qsTr("Secure Boot Warning")
                        color: "#f59f23"
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                    }

                    Controls.Label {
                        text: qsTr("Secure Boot is currently enabled. You may need to sign the kernel modules or disable Secure Boot to use NVIDIA drivers.")
                        color: mutedColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }
                }
            }

            Item {
                Layout.preferredHeight: 12
            }
        }
    }
}
