#!/bin/bash

current_count=$(i3-msg -t get_workspaces | jq length)
target_ws=$((current_count + 1))

# (Optional) Validate if within a safe range, say 1–20
if (( target_ws < 1 || target_ws > 20 )); then
    echo "Invalid workspace number: $target_ws"
    exit 1
fi

i3-msg "workspace number $target_ws"
sleep 0.2
# Apply layout
i3-msg "append_layout /home/z6/.i3/code.json" >/dev/null &

kitty -e nvim & 
sleep 2
kitty &
sleep 0.4
kitty --class=kitty -e cava &
sleep 0.4
kitty --class=kitty -e ~/.config/i3/scripts/play_media.sh 
