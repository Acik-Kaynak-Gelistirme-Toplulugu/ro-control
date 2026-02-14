import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import "../components"
import io.github.AcikKaynakGelistirmeToplulugu.rocontrol

Item {
    id: expertPage

    required property var controller
    required property bool darkMode
    signal showProgress
    signal goBack

    property string selectedVersion: ""
    property bool useOpenKernel: false
    property bool deepClean: false
    property var officialVersions: []

    readonly property color textColor: darkMode ? "#eef3f9" : "#2d3136"
    readonly property color mutedColor: darkMode ? "#aeb8c4" : "#77818b"
    readonly property color cardColor: darkMode ? "#2a333f" : "#f5f6f8"
    readonly property color borderColor: darkMode ? "#3b4655" : "#c8ced6"

    property var versionList: {
        var raw = controller.get_available_versions();
        if (raw.length === 0)
            return [];
        return raw.split(",");
    }

    property var displayVersions: {
        if (officialVersions.length > 0)
            return officialVersions;
        return versionList.map(function (v, idx) {
            return {
                version: v,
                changes: idx === 0 ? qsTr("Latest Stable") : qsTr("Official metadata unavailable"),
                is_latest: idx === 0
            };
        });
    }

    function refreshOfficialVersions() {
        try {
            var raw = controller.get_official_versions_with_changes();
            var parsed = JSON.parse(raw);
            officialVersions = parsed;
        } catch (e) {
            officialVersions = [];
        }
    }

    onVisibleChanged: {
        if (visible)
            refreshOfficialVersions();
    }

    Controls.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            width: Math.min(parent.width, 660)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            Item {
                Layout.preferredHeight: 24
            }

            Controls.Label {
                text: qsTr("Expert Driver Management")
                font.pixelSize: 20
                font.weight: Font.DemiBold
                color: textColor
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 78
                radius: 8
                color: cardColor
                border.width: 1
                border.color: borderColor

                GridLayout {
                    anchors.fill: parent
                    anchors.margins: 14
                    columns: 2
                    rowSpacing: 8
                    columnSpacing: 12

                    Controls.Label {
                        text: qsTr("Current:")
                        color: mutedColor
                        font.pixelSize: 14
                    }
                    Controls.Label {
                        text: controller.driver_in_use.length > 0 ? controller.driver_in_use : "nvidia-555.42 (proprietary)"
                        color: textColor
                        horizontalAlignment: Text.AlignRight
                        Layout.fillWidth: true
                        font.pixelSize: 14
                        font.weight: Font.DemiBold
                    }

                    Controls.Label {
                        text: qsTr("Kernel:")
                        color: mutedColor
                        font.pixelSize: 14
                    }
                    Controls.Label {
                        text: "6.8.12-300.fc40.x86_64"
                        color: textColor
                        horizontalAlignment: Text.AlignRight
                        Layout.fillWidth: true
                        font.pixelSize: 14
                        font.weight: Font.DemiBold
                    }
                }
            }

            Controls.GroupBox {
                Layout.fillWidth: true
                title: qsTr("Available Versions")

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    Repeater {
                        model: expertPage.displayVersions

                        VersionRow {
                            required property var modelData
                            required property int index

                            version: typeof modelData === "string" ? modelData : modelData.version
                            statusText: typeof modelData === "string" ? (index === 0 ? qsTr("Latest Stable") : "") : modelData.changes
                            status: (typeof modelData === "string" ? modelData : modelData.version) === controller.driver_in_use ? "installed" : "available"
                            selected: expertPage.selectedVersion === (typeof modelData === "string" ? modelData : modelData.version)
                            darkMode: expertPage.darkMode

                            onClicked: expertPage.selectedVersion = (typeof modelData === "string" ? modelData : modelData.version)

                            Layout.fillWidth: true
                        }
                    }

                    Controls.Label {
                        visible: expertPage.versionList.length === 0
                        text: qsTr("No versions available. Check internet connection.")
                        opacity: 0.5
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 12
                    }
                }
            }

            Controls.Label {
                text: qsTr("Versions are checked from official repository metadata and include available changelog summaries.")
                color: mutedColor
                font.pixelSize: 12
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }

            Controls.GroupBox {
                Layout.fillWidth: true
                title: qsTr("Kernel Module")

                RowLayout {
                    spacing: 16

                    Controls.RadioButton {
                        text: qsTr("Proprietary")
                        checked: !expertPage.useOpenKernel
                        onClicked: expertPage.useOpenKernel = false
                    }

                    Controls.RadioButton {
                        text: qsTr("Open")
                        checked: expertPage.useOpenKernel
                        onClicked: expertPage.useOpenKernel = true
                    }
                }
            }

            Controls.CheckBox {
                text: qsTr("Remove old configs (Deep Clean)")
                checked: expertPage.deepClean
                onToggled: expertPage.deepClean = checked
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                Controls.Button {
                    text: qsTr("Install Selected")
                    enabled: expertPage.selectedVersion.length > 0
                    highlighted: true
                    Layout.fillWidth: true
                    font.pixelSize: 16
                    palette.button: "#35a3df"
                    palette.buttonText: "#ffffff"
                    onClicked: {
                        controller.install_custom(expertPage.selectedVersion, expertPage.useOpenKernel);
                        expertPage.showProgress();
                    }
                }

                Controls.Button {
                    text: qsTr("Remove All & Reset")
                    Layout.fillWidth: true
                    font.pixelSize: 16
                    palette.button: "#f44646"
                    palette.buttonText: "#ffffff"
                    onClicked: removeDialog.open()
                }
            }

            Item {
                Layout.preferredHeight: 20
            }
        }
    }

    Controls.Dialog {
        id: removeDialog
        title: qsTr("Remove All Drivers?")
        modal: true
        anchors.centerIn: parent
        standardButtons: Controls.Dialog.Ok | Controls.Dialog.Cancel

        ColumnLayout {
            spacing: 8
            Controls.Label {
                text: qsTr("This will remove all NVIDIA drivers and reset to nouveau.\nA reboot will be required.")
                wrapMode: Text.WordWrap
            }
            Controls.CheckBox {
                text: qsTr("Also remove configuration files (deep clean)")
                checked: expertPage.deepClean
                onToggled: expertPage.deepClean = checked
            }
        }

        onAccepted: {
            controller.remove_drivers(expertPage.deepClean);
            expertPage.showProgress();
        }
    }
}
