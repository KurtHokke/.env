-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

config.enable_wayland = false

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575754',
  },
}

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 35

-- or, changing the font size and color scheme.
config.font_size = 14
config.font = wezterm.font('FiraMono Nerd Font Mono')

-- Finally, return the configuration to wezterm:
return config