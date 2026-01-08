import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

PanelWindow {
    required property var modelData

    screen: modelData
    implicitHeight: 30

    anchors {
        top: true
        left: true
        right: true
    }

    RowLayout {
        // left section

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        layoutDirection: Qt.LeftToRight

        Item {} // padding from left edge
        HyprlandWorkspacesWidget {}
        BarWidgetSeparator {}
        WaylandActiveWindowWidget {}
    }

    RowLayout {
        // middle section

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        layoutDirection: Qt.LeftToRight

        ClockWidget {}
    }

    RowLayout {
        // right section

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        layoutDirection: Qt.LeftToRight

        Text { text: "system tray" } // TODO
        BarWidgetSeparator {}
        Text { text: "bluetooth" } // TODO
        BarWidgetSeparator {}
        Text { text: "wifi" } // TODO
        BarWidgetSeparator {}
        Text { text: "volume" } // TODO
        BarWidgetSeparator {}
        Text { text: "battery" } // TODO
        BarWidgetSeparator {}
        Text { text: "lang" } // TODO
        BarWidgetSeparator {}
        Text { text: "settings" } // TODO
        BarWidgetSeparator {}
        Text { text: "power" } // TODO
        BarWidgetSeparator {}
        Text { text: "sys stats" } // TODO
        Item {} // padding from right edge
    }
}
