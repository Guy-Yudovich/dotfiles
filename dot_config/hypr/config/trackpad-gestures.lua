-------------------------
--- TRACKPAD GESTURES ---
-------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/

require("config.notifications")

---@diagnostic disable: assign-type-mismatch
hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ workspace = "m+1" })) end })
hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ workspace = "m-1" })) end })
hl.gesture({ fingers = 3, direction = "swipe", mods = "SUPER", action = "move" })

hl.gesture({ fingers = 4, direction = "up",    mods = "SUPER", action = function() hl.dispatch(hl.dsp.window.float({ action = "toggle" })) end })
hl.gesture({ fingers = 4, direction = "down",  action = function() hl.exec_cmd("playerctl play-pause && " .. NotifyCurrentTrack) end })
hl.gesture({ fingers = 4, direction = "left",  action = function() hl.exec_cmd("playerctl next && " .. NotifyCurrentTrack) end })
hl.gesture({ fingers = 4, direction = "right", action = function() hl.exec_cmd("playerctl previous && " .. NotifyCurrentTrack) end })
---@diagnostic enable: assign-type-mismatch
