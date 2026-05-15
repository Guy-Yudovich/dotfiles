---------------------
--- NOTIFICATIONS ---
---------------------

NotifyStat = "notify-send -t 500"
NotifyText = "notify-send -t 2500"

NotifyBrightness    = NotifyStat .. [[ "brightness: $(brightnessctl info | grep -i "current" | grep -Eo "[0-9]+%")"]]
NotifyVolume        = NotifyStat .. [[ "volume: $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d%%\n", $2*100}')"]]
NotifyCurrentTrack  = "sleep 0.5 && " .. NotifyText .. [[ "currently playing" "$(playerctl metadata | grep -i "title" | awk '{$1=$2=""; sub(/^[ \t]+/, ""); print}')"]]
