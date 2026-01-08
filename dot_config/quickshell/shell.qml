import Quickshell

import "Widgets"

Scope {
    Variants {
        model: Quickshell.screens

        StatusBar { screen: modelData }
    }
}
