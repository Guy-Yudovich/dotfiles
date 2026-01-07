pragma Singleton

import Quickshell
import QtQuick

Singleton { id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy")
    }

    SystemClock { id: clock
        precision: SystemClock.Second
    }

    // Timer {
    //     interval: 1000
    //     running: true
    //     repeat: true

    //     onTriggered: {
    //         date_proc.running = true
    //     }
    // }

    // Process { id: date_proc
    //     command: ["date"]
    //     running: true

    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             root.time = this.text
    //         }
    //     }
    // }
}