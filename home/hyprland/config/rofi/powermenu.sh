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
		  -theme "~/.config/rofi/powermenu.rasi")

if [ "$selected_option" == "$lock" ]
then
  swaylock
elif [ "$selected_option" == "$logout" ]
then
  loginctl terminate-user `whoami`
elif [ "$selected_option" == "$shutdown" ]
then
  poweroff
elif [ "$selected_option" == "$reboot" ]
then
  reboot
elif [ "$selected_option" == "$sleep" ]
then
  systemctl suspend
elif [ "$selected_option" == "$hibernate" ]
then
  systemctl hibernate
else
  echo "No match"
fi