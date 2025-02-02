{ self, ... }:
{
  programs.wezterm = {
    enable = true;

    extraConfig = ''
        -- Pull in the wezterm API
        local wezterm = require 'wezterm'
        
        -- This table will hold the configuration.
        local config = {}
        
        -- In newer versions of wezterm, use the config_builder which will
        -- help provide clearer error messages
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end
        
        -- This is where you actually apply your config choices
        config.font = wezterm.font 'IosevkaTerm Nerd Font'
        config.font_size = 32.0
        -- For example, changing the color scheme:
        config.color_scheme = ${if self.theme.dark then "'rose-pine-moon'" else "'rose-pine-dawn'"}
        
        config.hide_tab_bar_if_only_one_tab = true
        config.disable_default_key_bindings = false
        
        -- config.enable_wayland = false
        
        -- and finally, return the configuration to wezterm
        return config
    '';
  };
}
