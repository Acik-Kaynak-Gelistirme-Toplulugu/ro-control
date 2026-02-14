// qmllint disable import
// qmllint disable missing-property
// qmllint disable unqualified
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import "pages"
import io.github.AcikKaynakGelistirmeToplulugu.rocontrol

Controls.ApplicationWindow {
    id: root
    width: 1440
    height: 768
    minimumWidth: 1100
    minimumHeight: 680
    title: "ro-Control"
    visible: true
    property bool darkMode: false

    readonly property color cBg: darkMode ? "#151b22" : "#eef0f2"
    readonly property color cHeader: darkMode ? "#232b35" : "#f4f5f7"
    readonly property color cSubHeader: darkMode ? "#252e39" : "#eff1f3"
    readonly property color cSidebar: darkMode ? "#171f28" : "#e9ecef"
    readonly property color cCard: darkMode ? "#2a333f" : "#f5f6f8"
    readonly property color cBorder: darkMode ? "#3b4655" : "#c8ced6"
    readonly property color cText: darkMode ? "#eef3f9" : "#2d3136"
    readonly property color cMuted: darkMode ? "#aeb8c4" : "#77818b"
    readonly property color cNavActive: darkMode ? "#2f3947" : "#f8f9fb"
    readonly property color cPrimary: "#35a3df"

    background: Rectangle {
        color: root.cBg
    }
    color: root.cBg

    // --- Backend objects ---
    GpuController {
        id: gpuController
        Component.onCompleted: {
            check_network();
            detect_gpu();
        }
    }

    PerfMonitor {
        id: perfMonitor
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 58
            color: root.cHeader

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: root.cBorder
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 22
                anchors.rightMargin: 18

                Controls.Label {
                    text: "ro-Control"
                    font.pixelSize: 17
                    font.weight: Font.DemiBold
                    color: root.cText
                }

                Item {
                    Layout.fillWidth: true
                }

                Controls.ToolButton {
                    text: root.darkMode ? "☀" : "☾"
                    font.pixelSize: 20
                    onClicked: root.darkMode = !root.darkMode
                }

                Controls.ToolButton {
                    text: "ⓘ"
                    font.pixelSize: 20
                    onClicked: aboutDialog.open()
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 44
            color: root.cSubHeader

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: root.cBorder
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 22
                spacing: 24

                Controls.Label {
                    text: qsTr("Driver:") + "  " + (gpuController.driver_in_use.length > 0 ? gpuController.driver_in_use : "nvidia-560.xx")
                    color: root.cMuted
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                }

                Controls.Label {
                    text: qsTr("Secure Boot:") + "  " + (gpuController.secure_boot ? "ON" : "OFF")
                    color: root.cMuted
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                }

                Controls.Label {
                    text: qsTr("GPU:") + "  " + (gpuController.gpu_model.length > 0 ? gpuController.gpu_model : "RTX 4070")
                    color: root.cMuted
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            Rectangle {
                id: sidebar
                Layout.preferredWidth: 200
                Layout.fillHeight: true
                color: root.cSidebar

                Rectangle {
                    anchors.right: parent.right
                    width: 1
                    height: parent.height
                    color: root.cBorder
                    opacity: 0.5
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    // Nav buttons
                    Repeater {
                        model: [
                            {
                                label: qsTr("Install"),
                                icon: "download",
                                idx: 0
                            },
                            {
                                label: qsTr("Expert"),
                                icon: "configure",
                                idx: 1
                            },
                            {
                                label: qsTr("Monitor"),
                                icon: "utilities-system-monitor",
                                idx: 2
                            }
                        ]

                        Controls.Button {
                            required property var modelData

                            text: modelData.label
                            icon.name: modelData.icon
                            icon.color: root.cText
                            font.pixelSize: 16
                            leftPadding: 14

                            Layout.fillWidth: true
                            implicitHeight: 42
                            flat: true

                            background: Rectangle {
                                color: contentStack.currentIndex === modelData.idx ? root.cNavActive : "transparent"
                                radius: 4
                            }

                            contentItem: RowLayout {
                                spacing: 10

                                Controls.Label {
                                    text: parent.parent.icon.name === "utilities-system-monitor" ? "~" : (parent.parent.icon.name === "configure" ? "⚙" : "↓")
                                    color: root.cText
                                    font.pixelSize: 18
                                }

                                Controls.Label {
                                    text: parent.parent.text
                                    color: root.cText
                                    font.pixelSize: 16
                                    font.weight: Font.DemiBold
                                }
                            }

                            onClicked: contentStack.currentIndex = modelData.idx
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                    Controls.Label {
                        text: "v" + "1.1.0"
                        opacity: 0.75
                        font.pixelSize: 13
                        color: root.cMuted
                        Layout.leftMargin: 4
                    }
                }
            }

            // ─── Content Area ───
            StackLayout {
                id: contentStack
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: 0

                // Page 0: Install
                InstallPage {
                    controller: gpuController
                    darkMode: root.darkMode
                    onShowExpert: contentStack.currentIndex = 1
                    onShowProgress: contentStack.currentIndex = 3
                }

                // Page 1: Expert
                ExpertPage {
                    controller: gpuController
                    darkMode: root.darkMode
                    onShowProgress: contentStack.currentIndex = 3
                    onGoBack: contentStack.currentIndex = 0
                }

                // Page 2: Performance Monitor
                PerfPage {
                    monitor: perfMonitor
                    darkMode: root.darkMode
                }

                // Page 3: Progress
                ProgressPage {
                    controller: gpuController
                    darkMode: root.darkMode
                    onFinished: contentStack.currentIndex = 0
                }
            }
        }
    }

    Controls.Dialog {
        id: aboutDialog
        title: qsTr("About ro-Control")
        modal: true
        anchors.centerIn: parent
        standardButtons: Controls.Dialog.Ok

        ColumnLayout {
            spacing: 8
            width: 360

            Controls.Label {
                text: "ro-Control v1.1.0"
                font.pixelSize: 18
                font.weight: Font.DemiBold
                color: root.cText
            }

            Controls.Label {
                text: qsTr("Professional NVIDIA driver manager for Linux systems.")
                wrapMode: Text.WordWrap
                color: root.cMuted
                Layout.fillWidth: true
            }

            Controls.Label {
                text: qsTr("© Açık Kaynak Geliştirme Topluluğu")
                color: root.cMuted
            }
        }
    }
}
