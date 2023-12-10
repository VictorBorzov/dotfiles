#!/usr/bin/env sh

# Set dark wallpaper, doesn't work with hyprpaper's ipc
# hyprctl hyprpaper wallpaper "eDP-1,~/.config/background.jpg" 

if [[ "$DARK_MODE" != "False" ]]; then
    export DARK_MODE="False"
fi

# swww
swww img ~/.config/background.jpg

# Hyprland
sed -i 's/moon/dawn/' ~/dotfiles/config/hypr/hyprland.conf

# Wezterm
sed -i 's/moon/dawn/' ~/dotfiles/config/wezterm/wezterm.lua

# Zellij
sed -i 's/moon/dawn/' ~/dotfiles/config/zellij/config.kdl

# Helix
sed -i 's/moon/dawn/' ~/dotfiles/config/helix/config.toml 

# swaylock
sed -i 's/background-dark/background/' ~/dotfiles/config/swaylock/config 

# hyprpaper
# sed -i 's/background-dark/background/g' ~/dotfiles/config/hypr/hyprpaper.conf 

# emacs
sed -i 's/doom-one/doom-earl-grey/' ~/.emacs.d/my-init.org

# gtk 3.0
sed -i 's/gtk-application-prefer-dark-theme=true/gtk-application-prefer-dark-theme=false/' ~/dotfiles/config/gtk-3.0/settings.ini

# gtk 4.0
sed -i 's/gtk-application-prefer-dark-theme=true/gtk-application-prefer-dark-theme=false/' ~/dotfiles/config/gtk-4.0/settings.ini


