#!/usr/bin/env sh

swaylock -f &  # Lock the screen
sleep 1        # Wait a bit to ensure the lock screen is active
systemctl suspend  # Suspend the machine
