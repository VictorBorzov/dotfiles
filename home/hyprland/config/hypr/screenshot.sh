#!/usr/bin/env sh

DIR="$HOME/Pictures/Screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

if [ ! -d $DIR ]; then
    mkdir $DIR
    notify-send ".config folder created."
fi
FILE="$DIR$(date +'%s.png')"
REGION=$(slurp)
sleep 0.1
grim -g "$REGION" - | swappy -f - -o $FILE
notify-send "Screenshot $FILE created" "Mode: Selected area"

