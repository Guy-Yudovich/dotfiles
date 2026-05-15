require("config.programs")
require("config.notifications")
require("scripts")

-- See https://wiki.hypr.land/Configuring/Basics/Binds for more keybinds
local mainMod  = "SUPER" -- Sets "Windows" key as main modifier
local mainModP = mainMod .. " + "

-- Main keybinds
hl.bind(mainModP .. "Q",           hl.dsp.exec_cmd(Terminal))
hl.bind(mainModP .. "C",           hl.dsp.window.kill())
hl.bind(mainModP .. "K",           hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainModP .. "L",           hl.dsp.exit())
hl.bind(mainModP .. "E",           hl.dsp.exec_cmd(FileManager))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainModP .. "SPACE",       hl.dsp.exec_cmd(Menu))
hl.bind(mainModP .. "P",           hl.dsp.window.pseudo())
hl.bind(mainModP .. "J",           hl.dsp.layout("togglesplit"))
hl.bind(mainModP .. "F11",         hl.dsp.window.fullscreen())

-- Window/Workspace control
hl.bind(mainMod .. " + SHIFT + ALT + UP",    hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + ALT + DOWN",  hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + ALT + RIGHT", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + ALT + LEFT",  hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + UP",           hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + DOWN",         hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + LEFT",         hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + RIGHT",        hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + ALT + UP",     hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + ALT + DOWN",   hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + ALT + LEFT",   hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + ALT + RIGHT",  hl.dsp.window.move({ direction = "right" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainModP .. "LEFT",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainModP .. "RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind(mainModP .. "UP",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainModP .. "DOWN",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + ALT + arrows
hl.bind(mainMod .. " + ALT + UP",    hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + ALT + DOWN",  hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + ALT + RIGHT", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + ALT + LEFT",  hl.dsp.focus({ workspace = "m-1" }))

-- Switch/move workspaces with mainMod + [0-9] and mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = "r~" .. i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainModP .. "S",            hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S",  hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainModP .. "mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainModP .. "mouse_up",   hl.dsp.focus({ workspace = "m-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && " .. NotifyVolume),     { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && " .. NotifyVolume),           { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),                              { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),                            { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+ && " .. NotifyBrightness),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%- && " .. NotifyBrightness),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next && " .. NotifyCurrentTrack),               { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous && " .. NotifyCurrentTrack),           { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause && " .. NotifyCurrentTrack),         { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause && " .. NotifyCurrentTrack),         { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop && playerctl stop && " .. NotifyCurrentTrack), { locked = true })

-- Clipboard Manager
hl.bind(mainModP .. "V", hl.dsp.exec_cmd(Terminal .. " --class " .. Clip .. " -e '" .. Clip .. "'"))

-- Screen Capture
hl.bind("PRINT",         Screenshot())
hl.bind("SHIFT + PRINT", Screenshot(true))

-- Quick Access
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("kitten quick-access-terminal"))

-- Emoji Picker
hl.bind(mainModP .. "PERIOD",          hl.dsp.exec_cmd("rofimoji --action copy"))
hl.bind(mainMod .. " + ALT + PERIOD",  hl.dsp.exec_cmd("plasma-emojier"))

-- Freeze Process
hl.bind(mainModP .. "ESCAPE", hl.dsp.exec_cmd("hyprfreeze -a"))

-- Hyprctl Utilities
hl.bind(mainModP .. "w", hl.dsp.exec_cmd("hyprctl -j activewindow | kitty sh -c 'fx </proc/$PPID/fd/0'"))
