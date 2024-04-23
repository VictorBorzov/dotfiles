#!/usr/bin/env sh

# Select a screen area with slurp and capture it with grim, storing the image in memory (/dev/shm).
REGION=$(slurp)
if [ -z "$REGION" ]; then
    echo "No region selected."
    exit 1
fi

# Use /dev/shm for storing the image temporarily in memory
TEMP_FILE="/dev/shm/screenshot_$(date +%d%m%Y_%H%M%S).png"

# Capture the screenshot into the temporary file
grim -g "$REGION" "$TEMP_FILE"

# Use Tesseract OCR to extract text from the image
# Ensure you have tesseract and its language data installed
# You might need to specify the language with the -l flag, e.g., -l eng for English
tesseract "$TEMP_FILE" stdout

# Clean up the temporary file
rm "$TEMP_FILE"
