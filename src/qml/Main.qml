import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import "." as AppTheme
import "pages"
import io.github.AcikKaynakGelistirmeToplulugu.rocontrol

Controls.ApplicationWindow {
    id: root
    width: 960
    height: 680
    minimumWidth: 800
    minimumHeight: 600
    title: "ro-Control"
    visible: true

    // Set application background via Theme
    background: Rectangle {
        color: AppTheme.Theme.background
    }
    color: AppTheme.Theme.background

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

    // --- Layout: Sidebar + Content ---
    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ─── Sidebar ───
        Rectangle {
            id: sidebar
            Layout.preferredWidth: 200
            Layout.fillHeight: true
            color: AppTheme.Theme.sidebar

            Rectangle {
                anchors.right: parent.right
                width: 1
                height: parent.height
                color: AppTheme.Theme.border
                opacity: 0.5
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 4

                // App title
                Controls.Label {
                    text: "ro-Control"
                    font: AppTheme.Theme.fontH3
                    color: AppTheme.Theme.foreground
                    Layout.bottomMargin: 16
                }

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

                        Layout.fillWidth: true
                        flat: contentStack.currentIndex !== modelData.idx
                        highlighted: contentStack.currentIndex === modelData.idx

                        background: Rectangle {
                            color: parent.highlighted ? AppTheme.Theme.primary : "transparent"
                            radius: AppTheme.Theme.radiusSm
                        }

                        onClicked: contentStack.currentIndex = modelData.idx
                    }
                }

                Item {
                    Layout.fillHeight: true
                }

                // Status info
                Controls.Label {
                    visible: gpuController.secure_boot
                    text: "⚠ Secure Boot ON"
                    color: AppTheme.Theme.warning
                    font.pixelSize: 11
                }

                Controls.Label {
                    text: "v" + "1.0.0"
                    opacity: 0.4
                    font.pixelSize: 11
                    color: AppTheme.Theme.mutedForeground
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
                onShowExpert: contentStack.currentIndex = 1
                onShowProgress: contentStack.currentIndex = 3
            }

            // Page 1: Expert
            ExpertPage {
                controller: gpuController
                onShowProgress: contentStack.currentIndex = 3
                onGoBack: contentStack.currentIndex = 0
            }

            // Page 2: Performance Monitor
            PerfPage {
                monitor: perfMonitor
            }

            // Page 3: Progress
            ProgressPage {
                controller: gpuController
                onFinished: contentStack.currentIndex = 0
            }
        }
    }
}
