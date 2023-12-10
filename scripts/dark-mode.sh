#!/usr/bin/env sh

export DARK_MODE=True
# Set dark wallpaper, doesn't work with hyprpaper's ipc
# hyprctl hyprpaper wallpaper "eDP-1,~/.config/background-dark.jpg" 

if [[ "$DARK_MODE" != "True" ]]; then
    export DARK_MODE="True"
fi

# swww
swww img ~/.config/background-dark.jpg

# Hyprland
sed -i 's/dawn/moon/' ~/dotfiles/config/hypr/hyprland.conf

# Wezterm
sed -i 's/dawn/moon/' ~/dotfiles/config/wezterm/wezterm.lua

# Zellij
sed -i 's/dawn/moon/' ~/dotfiles/config/zellij/config.kdl 

# Helix
sed -i 's/dawn/moon/' ~/dotfiles/config/helix/config.toml 

# swaylock
sed -i 's/background/background-dark/' ~/dotfiles/config/swaylock/config 

# hyprpaper
#sed -i 's/background/background-dark/g' ~/dotfiles/config/hypr/hyprpaper.conf 

# emacs
sed -i 's/doom-earl-grey/doom-one/' ~/.emacs.d/my-init.org

# gtk 3.0
sed -i 's/gtk-application-prefer-dark-theme=false/gtk-application-prefer-dark-theme=true/' ~/dotfiles/config/gtk-3.0/settings.ini

# gtk 4.0
sed -i 's/gtk-application-prefer-dark-theme=false/gtk-application-prefer-dark-theme=true/' ~/dotfiles/config/gtk-4.0/settings.ini

# Change gtk in hyprland.conf
sed -i 's/env = GTK_THEME,Breeze-Dark/env = GTK_THEME,Breeze/' ~/dotfiles/config/hypr/hyprland.conf

# Change qt in hyprland.conf
sed -i 's/env = QT_STYLE_OVERRIDE,Breeze-Dark/env = QT_STYLE_OVERRIDE,Breeze/' ~/dotfiles/config/hypr/hyprland.conf
