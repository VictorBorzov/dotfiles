
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
config.font_size = 16.0
--config.font = wezterm.font 'JetBrains Mono'
-- For example, changing the color scheme:
config.color_scheme = 'rose-pine-moon'

config.hide_tab_bar_if_only_one_tab = true
config.disable_default_key_bindings = false

-- config.unix_domains = {
--   {
--     name = 'unix',
--   },
-- }

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
-- config.default_gui_startup_args = { 'connect', 'unix' }

-- and finally, return the configuration to wezterm
return config
