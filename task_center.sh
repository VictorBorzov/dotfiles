#!/bin/bash

# Get the description of the started task or "No task" if none
task_description=$(task +ACTIVE export | jq -r 'if length > 0 then .[].description else "No task" end')

# Get the terminal width
terminal_width=$(tput cols)

# Get the length of the task description
task_description_length=${#task_description}

# Calculate padding
padding=$(( (terminal_width - task_description_length) / 2 ))

# Generate spaces for padding
spaces=$(printf "%${padding}s")

# Print the padded task description
echo "${spaces}${task_description}"

