pragma Singleton
import QtQuick
import QtQuick.Controls

QtObject {
    id: theme

    // Stable default theme mode
    property bool isDark: false

    // ─── Font Settings ───
    property int fontSize: 16
    property int fontWeightNormal: 400
    property int fontWeightMedium: 500

    property font fontH1: Qt.font({
        pixelSize: 24,
        weight: fontWeightMedium
    }) // text-2xl
    property font fontH2: Qt.font({
        pixelSize: 20,
        weight: fontWeightMedium
    }) // text-xl
    property font fontH3: Qt.font({
        pixelSize: 18,
        weight: fontWeightMedium
    }) // text-lg
    property font fontBody: Qt.font({
        pixelSize: fontSize,
        weight: fontWeightNormal
    })

    // ─── Colors (Dynamic based on differs) ───

    // Backgrounds
    property color background: isDark ? "#131920" : "#eef0f2"
    property color card: isDark ? "#262d36" : "#f5f6f8"
    property color popover: isDark ? "#262d36" : "#ffffff"
    property color sidebar: isDark ? "#141a21" : "#e9ecef"
    property color header: isDark ? "#222933" : "#f4f5f7"
    property color subHeader: isDark ? "#252c35" : "#eff1f3"
    property color navActive: isDark ? "#2b3340" : "#f8f9fb"
    property color overlay: isDark ? "#000000" : "#ffffff"  // Custom extra

    // Foregrounds (Text)
    property color foreground: isDark ? "#f2f4f7" : "#2d3136"
    property color cardForeground: isDark ? "#eff0f1" : "#232629"
    property color popoverForeground: isDark ? "#eff0f1" : "#232629"
    property color sidebarForeground: isDark ? "#eff0f1" : "#232629"
    property color mutedForeground: isDark ? "#aeb6c0" : "#77818b"

    // Brand / Primary
    property color primary: isDark ? "#3ca9df" : "#3490c9"
    property color primaryForeground: isDark ? "#1b1e20" : "#ffffff"

    property color accent: isDark ? "#3daee9" : "#2980b9"
    property color accentForeground: isDark ? "#1b1e20" : "#ffffff"

    // Functional
    property color destructive: isDark ? "#ed1515" : "#da4453"
    property color destructiveForeground: "#ffffff"

    property color success: "#2eb66d"
    property color warning: isDark ? "#f08b21" : "#f59f23"
    property color error: isDark ? "#ff3c3c" : "#e44d4d"

    // UI Elements
    property color border: isDark ? "#384252" : "#c8ced6"
    property color input: isDark ? "#2a2e32" : "transparent"
    property color inputBackground: isDark ? "#2a2e32" : "#fcfcfc"
    property color ring: isDark ? "#3daee9" : "#2980b9"

    // ─── Dimensions ───
    property int radius: 8 // 0.5rem approx
    property int radiusSm: 4
    property int radiusLg: 12

    // ─── Helper Functions ───
    function alpha(colorVal, alphaVal) {
        return Qt.rgba(colorVal.r, colorVal.g, colorVal.b, alphaVal);
    }
}
