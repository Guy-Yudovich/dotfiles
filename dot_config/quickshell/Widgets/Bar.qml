import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Scope { id: root
    Variants {
        model: Quickshell.screens

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
                Text { text: "workspaces"} // TODO
                BarSeparator {}
                Text { text: "active window title"} // TODO
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
                BarSeparator {}
                Text { text: "bluetooth" } // TODO
                BarSeparator {}
                Text { text: "wifi" } // TODO
                BarSeparator {}
                Text { text: "volume" } // TODO
                BarSeparator {}
                Text { text: "battery" } // TODO
                BarSeparator {}
                Text { text: "lang" } // TODO
                BarSeparator {}
                Text { text: "settings" } // TODO
                BarSeparator {}
                Text { text: "sys stats" } // TODO
                Item {} // padding from right edge
            }
        }
    }
}
