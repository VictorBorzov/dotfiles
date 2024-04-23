#!/usr/bin/env sh



# Fetch the remaining time for the current Org timer
timer_remaining=$(emacsclient -e "(my-org-timer-remaining-time)" | sed 's/^"\(.*\)"$/\1/' | sed 's/\\//g')

# Fetch the current task name from the active Org clock
task_name=$(emacsclient -e '(if (org-clocking-p)
                                (let* ((task-name (if org-clock-current-task (substring-no-properties org-clock-current-task) "No active task")))
                                  (format "%s" task-name))
                              "No active task")' | sed 's/^"\(.*\)"$/\1/' | sed 's/\\//g')

# Conditional logic to decide what to print
if [ "$task_name" = "No active task" ]; then
    echo "No active task"
elif [ "$timer_remaining" = "No timer set" ]; then
    echo "$task_name"
else
    echo "${task_name} [${timer_remaining}]"
fi
