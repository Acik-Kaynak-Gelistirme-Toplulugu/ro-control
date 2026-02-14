pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import "../components"
import io.github.AcikKaynakGelistirmeToplulugu.rocontrol

// Performance Monitor — Live GPU/CPU/RAM stats + system info
// Shows real-time metrics when driver is installed

Item {
    id: perfPage

    required property var monitor
    required property bool darkMode

    readonly property color textColor: perfPage.darkMode ? "#eef3f9" : "#2d3136"
    readonly property color mutedColor: perfPage.darkMode ? "#aeb8c4" : "#77818b"

    // Load system info once when page becomes visible
    onVisibleChanged: {
        if (visible) {
            perfPage.monitor.load_system_info();
            refreshTimer.start();
        } else {
            refreshTimer.stop();
        }
    }

    // Refresh live stats every 2s ONLY when visible
    Timer {
        id: refreshTimer
        interval: 2000
        repeat: true
        running: false
        onTriggered: perfPage.monitor.refresh()
    }

    Controls.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            width: Math.min(parent.width, 660)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 18

            Item {
                Layout.preferredHeight: 24
            }

            // ─── System Information ───
            Controls.GroupBox {
                Layout.fillWidth: true
                title: qsTr("System Information")

                GridLayout {
                    columns: 2
                    columnSpacing: 16
                    rowSpacing: 8
                    anchors.fill: parent

                    Controls.Label {
                        text: qsTr("OS:")
                        color: perfPage.mutedColor
                    }
                    Controls.Label {
                        text: perfPage.monitor.distro
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignRight
                        font.weight: Font.DemiBold
                        color: perfPage.textColor
                    }

                    Controls.Label {
                        text: qsTr("Kernel:")
                        color: perfPage.mutedColor
                    }
                    Controls.Label {
                        text: perfPage.monitor.kernel
                        horizontalAlignment: Text.AlignRight
                        Layout.fillWidth: true
                        font.weight: Font.DemiBold
                        color: perfPage.textColor
                    }

                    Controls.Label {
                        text: qsTr("CPU:")
                        color: perfPage.mutedColor
                    }
                    Controls.Label {
                        text: perfPage.monitor.cpu_name
                        horizontalAlignment: Text.AlignRight
                        Layout.fillWidth: true
                        font.weight: Font.DemiBold
                        color: perfPage.textColor
                    }

                    Controls.Label {
                        text: qsTr("RAM:")
                        color: perfPage.mutedColor
                    }
                    Controls.Label {
                        text: perfPage.monitor.ram_info
                        horizontalAlignment: Text.AlignRight
                        Layout.fillWidth: true
                        font.weight: Font.DemiBold
                        color: perfPage.textColor
                    }

                    Controls.Label {
                        text: qsTr("GPU:")
                        color: perfPage.mutedColor
                    }
                    Controls.Label {
                        text: perfPage.monitor.gpu_full_name
                        horizontalAlignment: Text.AlignRight
                        Layout.fillWidth: true
                        font.weight: Font.DemiBold
                        color: perfPage.textColor
                    }

                    Controls.Label {
                        text: qsTr("Display:")
                        color: perfPage.mutedColor
                    }
                    Controls.Label {
                        text: perfPage.monitor.display_server
                        horizontalAlignment: Text.AlignRight
                        Layout.fillWidth: true
                        font.weight: Font.DemiBold
                        color: perfPage.textColor
                    }
                }
            }

            // ─── GPU Live Status ───
            Controls.GroupBox {
                Layout.fillWidth: true
                title: qsTr("GPU Status")

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    StatRow {
                        label: qsTr("Temperature")
                        value: perfPage.monitor.gpu_temp + " °C"
                        fraction: perfPage.monitor.gpu_temp / 100.0
                        darkMode: perfPage.darkMode
                    }

                    StatRow {
                        label: qsTr("Load")
                        value: perfPage.monitor.gpu_load + " %"
                        fraction: perfPage.monitor.gpu_load / 100.0
                        darkMode: perfPage.darkMode
                    }

                    StatRow {
                        label: qsTr("VRAM")
                        value: perfPage.monitor.gpu_mem_used + " / " + perfPage.monitor.gpu_mem_total + " MB"
                        fraction: perfPage.monitor.gpu_mem_total > 0 ? perfPage.monitor.gpu_mem_used / perfPage.monitor.gpu_mem_total : 0
                        darkMode: perfPage.darkMode
                    }
                }
            }

            // ─── System Live Status ───
            Controls.GroupBox {
                Layout.fillWidth: true
                title: qsTr("System Usage")

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    StatRow {
                        label: qsTr("CPU Load")
                        value: perfPage.monitor.cpu_load + " %"
                        fraction: perfPage.monitor.cpu_load / 100.0
                        darkMode: perfPage.darkMode
                    }

                    StatRow {
                        label: qsTr("CPU Temp")
                        value: perfPage.monitor.cpu_temp + " °C"
                        fraction: perfPage.monitor.cpu_temp / 100.0
                        darkMode: perfPage.darkMode
                    }

                    StatRow {
                        label: qsTr("RAM")
                        value: perfPage.monitor.ram_used + " / " + perfPage.monitor.ram_total + " MB"
                        fraction: perfPage.monitor.ram_total > 0 ? perfPage.monitor.ram_used / perfPage.monitor.ram_total : 0
                        darkMode: perfPage.darkMode
                    }
                }
            }

            Item {
                Layout.preferredHeight: 20
            }
        }
    }
}
