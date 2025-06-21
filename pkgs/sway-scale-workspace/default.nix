{
  writeShellScriptBin,
  lib,
  jq,
  libnotify,
}: let
  _ = lib.getExe;
in
  writeShellScriptBin "sway-scale-workspace" ''
    OUTPUT="eDP-1"
    SCALE_FOR_WS="1"
    DEFAULT_SCALE="2"
    TARGET_WS="1"
    CURRENT_SCALE=""

    while true; do
        FOCUSED_WS=$(swaymsg -t get_workspaces | ${jq}/bin/jq -r '.[] | select(.focused) | .name')
        if [ "$FOCUSED_WS" = "$TARGET_WS" ]; then
            if [ "$CURRENT_SCALE" != "$SCALE_FOR_WS" ]; then
                swaymsg output "$OUTPUT" scale "$SCALE_FOR_WS"
                ${libnotify}/bin/notify-send "Workspace $FOCUSED_WS → scale $SCALE_FOR_WS"
                CURRENT_SCALE="$SCALE_FOR_WS"
            fi
        else
            if [ "$CURRENT_SCALE" != "$DEFAULT_SCALE" ]; then
                swaymsg output "$OUTPUT" scale "$DEFAULT_SCALE"
                ${libnotify}/bin/notify-send "Workspace $FOCUSED_WS → scale $DEFAULT_SCALE"
                CURRENT_SCALE="$DEFAULT_SCALE"
            fi
        fi
        sleep 0.3
    done
  ''

