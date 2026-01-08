import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    Repeater {
        model: Hyprland.workspaces

        Text {
            text: modelData.name
            // TODO: Make clickable to switch workspace
            // TODO: Style differently if active workspace
        }
    }
}
