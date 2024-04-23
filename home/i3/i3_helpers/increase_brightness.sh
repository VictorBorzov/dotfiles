#!/bin/sh

# Get the path to the amdgpu backlight folder
backlight_folder="/sys/class/backlight/amdgpu_bl1"


# Check if the folder exists
if [ ! -d "$backlight_folder" ]; then
  echo "Error: Invalid path to the amdgpu backlight folder."
  exit 1
fi

# Read the max_brightness value
max_brightness=$(cat "$backlight_folder/max_brightness")

# Read the actual_brightness value
actual_brightness=$(cat "$backlight_folder/actual_brightness")

# Calculate the 10% step increase
brightness_step=$((max_brightness * 10 / 100))

# Calculate the new brightness value
new_brightness=$((actual_brightness + brightness_step))

# Make sure the new brightness doesn't exceed the max_brightness
if [ "$new_brightness" -gt "$max_brightness" ]; then
  new_brightness="$max_brightness"
fi

# Write the new brightness value to the brightness file
echo "$new_brightness" | sudo tee "$backlight_folder/brightness"

exit 0
