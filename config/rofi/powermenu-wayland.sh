#!/bin/bash
 
lock=" Lock"
logout="󰍃 Logout"
shutdown=" Poweroff"
reboot=" Reboot"
sleep=" Suspend"
hibernate="󰤁 Hibernate"
 
selected_option=$(echo "$lock
$logout
$sleep
$hibernate
$reboot
$shutdown" | rofi -dmenu -i -p "" \
		  -theme "~/.config/rofi/powermenu-wayland.rasi")

if [ "$selected_option" == "$lock" ]
then
  hyprlock
elif [ "$selected_option" == "$logout" ]
then
  hyprctl dispatch exit
elif [ "$selected_option" == "$shutdown" ]
then
  poweroff
elif [ "$selected_option" == "$reboot" ]
then
  reboot
elif [ "$selected_option" == "$sleep" ]
then
  hyprlock &  # Lock the screen
  sleep 1        # Wait a bit to ensure the lock screen is active
  systemctl suspend  # Suspend the machine
elif [ "$selected_option" == "$hibernate" ]
then
  hyprlock &  # Lock the screen
  sleep 1        # Wait a bit to ensure the lock screen is active
  systemctl hibernate
else
  echo "No match"
fi
