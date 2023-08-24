-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Start of my configuration

-- Set a light theme, not using the built-in as this version also applies to the tab bar
local colors = require('lua/rose-pine-dawn').colors()
local window_frame = require('lua/rose-pine-dawn').window_frame()

config.colors = colors
config.window_frame = window_frame -- needed only if using fancy tab bar

-- Using a patched MonoLisa
config.font = wezterm.font_with_fallback {
  'MonoLisa Nerd Font',
  'JetBrains Mono',
  'DengXian',
}

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'm',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = 'LeftArrow', mods = 'SHIFT | SUPER', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'SHIFT | SUPER', action = wezterm.action.ActivateTabRelative(1) },
}

-- needed for french keyboards to work properly
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- config.debug_key_events = true

-- and finally, return the configuration to wezterm
return config
