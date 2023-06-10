# dawn
thm_base="#faf4ed"; # Used for
thm_surface="#fffaf3"; # Used for
thm_overlay="#f2e9e1"; # Used for
thm_muted="#9893a5"; # Used for
thm_subtle="#797593"; # Used for
thm_text="#575279"; # Used for
thm_love="#b4367a"; # Used for
thm_gold="#ea9d34"; # Used for
thm_rose="#d7827e"; # Used for
thm_pine="#286983"; # Used for
thm_foam="#56949f"; # Used for
thm_iris="#907aa9"; # Used for
thm_hl_low="#f4ede8"; # Used for
thm_hl_med="#dfdad9"; # Used for
thm_hl_high="#cecacd"; # Used for

# # Status bar
set -g "status" "on"
set -g status-style "fg=$thm_pine,bg=$thm_base"
set -g monitor-activity "on"
set -g status-justify "left"
set -g status-left-length "100"
set -g status-right-length "100"

# Theoretically messages (need to figure out color placement) 
set -g message-style "fg=$thm_muted,bg=$thm_base,align=centre"
set -g message-command-style "fg=$thm_base,bg=$thm_gold,align=centre"

# Pane styling
set -g pane-border-style "fg=$thm_hl_high"
set -g pane-active-border-style "fg=$thm_gold"
set -g display-panes-active-colour "${thm_text}"
set -g display-panes-colour "${thm_gold}"

# Windows
setw -g window-status-separator "  "
setw -g window-status-style "fg=${thm_iris},bg=${thm_base}"
setw -g window-status-activity-style "fg=${thm_base},bg=${thm_rose}"
setw -g window-status-current-style "fg=${thm_gold},bg=${thm_base}"

# Statusline base command configuration: No need to touch anything here
# Placement is handled below

# NOTE: Checking for the value of @rose_pine_window_tabs_enabled
window=""

user="vb"

host=""

date_time=""

directory=""

wt_enabled="off"

right_separator=" "

left_separator="  "

field_separator=" | "

spacer=" "


# These variables are the defaults so that the setw and set calls are easier to parse
show_window=" #[fg=$thm_subtle] #[fg=$thm_rose]#W$left_separator"
show_window_in_window_status="#[fg=$thm_fg,bg=$thm_bg] #W #[fg=$thm_bg,bg=$thm_foam] #I#[fg=$thm_foam,bg=$thm_bg]$left_separator#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "
show_window_in_window_status_current="#[fg=$thm_fg] #W #[fg=$thm_bg] #I#[fg=$thm_orange,bg=$thm_bg]$left_separator#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "
show_session=" #[fg=$thm_text] #[fg=$thm_text]#S "
show_user="#[fg=$thm_iris]#(whoami) #[fg=$thm_subtle]$right_separator#[fg=$thm_subtle] "
show_host=" #[fg=$thm_text]#H #[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]󰒋"
show_date_time="$field_separator#[fg=$thm_foam]%R #[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]󰃰"
show_directory=" #[fg=$thm_subtle] #[fg=$thm_rose]#{b:pane_current_path} #{?client_prefix,$spacer#[fg=${thm_love}]$right_separator#[fg=$thm_bg] $field_separator"
show_directory_in_window_status="#[fg=$thm_bg] #I #[fg=$thm_fg] #{b:pane_current_path} "
show_directory_in_window_status_current=" #I #[fg=$thm_iris,bg=$thm_bg] #{b:pane_current_path}"
# Left column placement: Determined by the set status-left on line 236

#Right columns organization:

# Right column 1 shows, by default, the username
right_column1=$show_user
# Right column 2 shows, by default, the current directory you're working on
right_column2=$spacer$show_directory
# Window status by default shows the current directory basename
window_status_format=$show_directory_in_window_status
window_status_current_format=$show_directory_in_window_status_current


window_status_format=$show_window_in_window_status
window_status_current_format=$show_window_in_window_status


right_column1=$right_column1$show_host
right_column1=$right_column1$show_date_time

# if [[ "$user" == "on" ]]; then
#right_column1=$right_column1$show_user
# fi
#
# if [[ "$directory" == "on" ]]; then
#right_column1=$right_column1$show_directory
# fi


set -g status-left "$show_session$show_window"

set -g status-right "$right_column1$right_column2"

set -g status-interval 1

setw -g window-status-format "$window_status_format"

setw -g window-status-current-format "$window_status_current_format"


# tmux integrated modes 

setw -g clock-mode-colour "${thm_love}"
setw -g mode-style "fg=${thm_gold}"
