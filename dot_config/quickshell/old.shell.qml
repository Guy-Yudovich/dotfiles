import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Scope {
  id: root
  property string currentTime: ""
  property string currentDate: ""
  property real currentVolume: 0.0
  property bool volumeMuted: false

  // Update time every second
  Timer {
	interval: 250
	running: true
	repeat: true
	triggeredOnStart: true
	onTriggered: {
	}
  }

  // Update volume more frequently (every 250ms)
  Timer {
	interval: 250
	running: true
	repeat: true
	triggeredOnStart: true
	onTriggered: {
	  volumeCheck.running = true
	  var now = new Date()
	  root.currentTime = Qt.formatTime(now, "hh:mm:ss")
	  root.currentDate = Qt.formatDate(now, "ddd, MMM d")
	}
  }

  // Get volume using wpctl
  Process {
	id: volumeCheck
	command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
	running: false

	stdout: SplitParser {
	  onRead: data => {
		var line = data.trim()
		// Output is like "Volume: 0.25" or "Volume: 0.25 [MUTED]"
		var parts = line.split(" ")
		if (parts.length >= 2) {
		  root.currentVolume = parseFloat(parts[1])
		  root.volumeMuted = line.includes("[MUTED]")
		}
	  }
	}
  }

  // Create a bar on every monitor
  Variants {
	model: Quickshell.screens

	PanelWindow {
	  property var modelData
	  screen: modelData

	  anchors {
		top: true
		left: true
		right: true
	  }

	  implicitHeight: 32
	  color: "#1a1b26"

	  RowLayout {
		anchors.fill: parent
		anchors.margins: 4
		spacing: 12

		// LEFT SECTION - Workspaces and Window Title
		RowLayout {
		  spacing: 8

		  // Workspaces (1-9)
		  RowLayout {
			spacing: 4

			Repeater {
			  model: 12

			  Rectangle {
				id: workspaceRect
				property int workspaceId: index + 1
				property var workspace: {
				  for (var i = 0; i < Hyprland.workspaces.values.length; i++) {
					if (Hyprland.workspaces.values[i].id === workspaceId) {
					  return Hyprland.workspaces.values[i]
					}
				  }
				  return null
				}
				property bool isActive: Hyprland.focusedWorkspace?.id === workspaceId
				property int windowCount: {
				  var count = 0
				  for (var i = 0; i < Hyprland.toplevels.values.length; i++) {
					if (Hyprland.toplevels.values[i].workspace.id === workspaceId) {
					  count++
					}
				  }
				  return count
				}
				property bool hasWindows: windowCount > 0

				Layout.preferredWidth: 28
				Layout.preferredHeight: 24
				radius: 4
				color: isActive ? "#7aa2f7" : (hasWindows ? "#414868" : "transparent")
				border.color: hasWindows ? "#565f89" : "#414868"
				border.width: 1

				Text {
				  anchors.centerIn: parent
				  text: workspaceRect.workspaceId
				  color: workspaceRect.isActive ? "#1a1b26" : (workspaceRect.hasWindows ? "#c0caf5" : "#565f89")
				  font.pixelSize: 13
				  font.bold: workspaceRect.isActive
				  font.family: "Adwaita Sans"
				}

				MouseArea {
				  anchors.fill: parent
				  onClicked: {
					Hyprland.dispatch("workspace " + workspaceRect.workspaceId)
				  }
				  cursorShape: Qt.PointingHandCursor
				}
			  }
			}
		  }

		  // Separator
		  Rectangle {
			Layout.preferredWidth: 1
			Layout.preferredHeight: 20
			color: "#414868"
		  }

		  // Active Window Title
		  Text {
			property var activeWindow: Hyprland.activeToplevel
			property bool hasWindowOnCurrentWorkspace: {
			  if (!Hyprland.focusedWorkspace) return false
			  var wsId = Hyprland.focusedWorkspace.id
			  for (var i = 0; i < Hyprland.toplevels.values.length; i++) {
				if (Hyprland.toplevels.values[i].workspace.id === wsId) {
				  return true
				}
			  }
			  return false
			}
			Layout.fillWidth: true
			Layout.maximumWidth: 400
			text: hasWindowOnCurrentWorkspace && activeWindow ? activeWindow.title : "Desktop"
			color: "#a9b1d6"
			font.pixelSize: 13
			font.family: "Adwaita Sans"
			elide: Text.ElideRight
		  }
		}

		// CENTER SPACER
		Item {
		  Layout.fillWidth: true
		}

		// RIGHT SECTION - System Info
		RowLayout {
		  spacing: 8

		  // System Tray
		  RowLayout {
			spacing: 6
			visible: SystemTray.items.length > 0

			Repeater {
			  model: SystemTray.items

			  Image {
				source: modelData.icon
				Layout.preferredWidth: 20
				Layout.preferredHeight: 20
				smooth: true

				MouseArea {
				  anchors.fill: parent
				  acceptedButtons: Qt.LeftButton | Qt.RightButton
				  onClicked: mouse => {
					if (mouse.button === Qt.LeftButton) {
					  modelData.activate()
					} else if (mouse.button === Qt.RightButton && modelData.hasMenu) {
					  modelData.display(parent, mouse.x, mouse.y)
					}
				  }
				  cursorShape: Qt.PointingHandCursor
				}
			  }
			}

			// Separator
			Rectangle {
			  Layout.preferredWidth: 1
			  Layout.preferredHeight: 20
			  color: "#414868"
			  visible: SystemTray.items.length > 0
			}
		  }

		  // Volume
		  Rectangle {
			Layout.preferredWidth: volumeRow.implicitWidth + 8
			Layout.preferredHeight: 24
			radius: 4
			color: "transparent"
			border.color: "#414868"
			border.width: 1

			RowLayout {
			  id: volumeRow
			  anchors.centerIn: parent
			  spacing: 4

			  Text {
				text: root.volumeMuted ? "󰝟" : "󰕾"
				color: root.volumeMuted ? "#f7768e" : "#9ece6a"
				font.pixelSize: 14
			  }

			  Text {
				text: Math.round(root.currentVolume * 100) + "%"
				color: "#a9b1d6"
				font.pixelSize: 12
				font.family: "Adwaita Sans"
			  }
			}

			MouseArea {
			  anchors.fill: parent
			  acceptedButtons: Qt.LeftButton | Qt.RightButton

			  onClicked: function(mouse) {
				// Toggle mute
				var proc = Quickshell.Io.Process.exec("wpctl", ["set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])
				volumeCheck.running = true
			  }

			  onWheel: function(wheel) {
				// Adjust volume by 5%
				var delta = wheel.angleDelta.y > 0 ? "+5%" : "5%-"
				var proc = Quickshell.Io.Process.exec("wpctl", ["set-volume", "@DEFAULT_AUDIO_SINK@", delta])
				volumeCheck.running = true
			  }

			  cursorShape: Qt.PointingHandCursor
			}
		  }

		  // Separator
		  Rectangle {
			Layout.preferredWidth: 1
			Layout.preferredHeight: 20
			color: "#414868"
		  }

		  // Battery
		  Rectangle {
			property var battery: {
			  var devices = UPower.devices.values
			  for (var i = 0; i < devices.length; i++) {
				if (devices[i].isLaptopBattery) {
				  return devices[i]
				}
			  }
			  return null
			}
			Layout.preferredWidth: batteryRow.implicitWidth + 8
			Layout.preferredHeight: 24
			radius: 4
			color: "transparent"
			border.color: "#414868"
			border.width: 1
			visible: battery !== null

			RowLayout {
			  id: batteryRow
			  anchors.centerIn: parent
			  spacing: 4

			  Text {
				text: {
				  var bat = parent.parent.battery
				  if (!bat) return ""
				  var pct = bat.percentage * 100  // percentage is 0-1, convert to 0-100
				  if (bat.state === UPowerDeviceState.Charging) return "󰂄"
				  if (pct > 90) return "󰁹"
				  if (pct > 80) return "󰂂"
				  if (pct > 70) return "󰂁"
				  if (pct > 60) return "󰂀"
				  if (pct > 50) return "󰁿"
				  if (pct > 40) return "󰁾"
				  if (pct > 30) return "󰁽"
				  if (pct > 20) return "󰁼"
				  if (pct > 10) return "󰁻"
				  return "󰁺"
				}
				color: {
				  var bat = parent.parent.battery
				  if (!bat) return "#a9b1d6"
				  var pct = bat.percentage * 100
				  if (bat.state === UPowerDeviceState.Charging) return "#9ece6a"
				  if (pct < 20) return "#f7768e"
				  if (pct < 40) return "#e0af68"
				  return "#a9b1d6"
				}
				font.pixelSize: 14
			  }

			  Text {
				text: {
				  var bat = parent.parent.battery
				  if (!bat) return ""
				  var pct = bat.percentage * 100  // percentage is 0-1, convert to 0-100
				  return Math.round(pct) + "%"
				}
				color: "#a9b1d6"
				font.pixelSize: 12
				font.family: "Adwaita Sans"
			  }
			}
		  }

		  // Separator (only show if battery exists)
		  Rectangle {
			property var battery: {
			  var devices = UPower.devices.values
			  for (var i = 0; i < devices.length; i++) {
				if (devices[i].isLaptopBattery) {
				  return devices[i]
				}
			  }
			  return null
			}
			Layout.preferredWidth: 1
			Layout.preferredHeight: 20
			color: "#414868"
			visible: battery !== null
		  }

		  // Clock
            Rectangle {
                Layout.preferredWidth: clockRow.implicitWidth + 8
                Layout.preferredHeight: 24
                radius: 4
                color: "transparent"
                border.color: "#414868"
                border.width: 1

                RowLayout {
                    id: clockRow
                    anchors.centerIn: parent
                    spacing: 4

                    Text {
                        text: "󰥔"
                        color: "#7aa2f7"
                        font.pixelSize: 14
                    }

                    Text {
                        text: root.currentTime
                        color: "#c0caf5"
                        font.pixelSize: 12
                        font.bold: true
                        font.family: "GeistMono Nerd Font"
                    }

                    Text {
                        text: root.currentDate
                        color: "#a9b1d6"
                        font.pixelSize: 12
                        font.family: "Adwaita Sans"
                    }
                }
            }
		}
	  }
	}
  }
}
