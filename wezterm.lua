-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Start of my configuration

config.default_prog = { '/opt/homebrew/bin/nu' }

-- Set a light theme, not using the built-in as this version also applies to the tab bar
local theme = require('lua/rose-pine').dawn

config.colors = theme.colors()
config.window_frame = theme.window_frame() -- needed only if using fancy tab bar
config.window_background_opacity = 1
config.adjust_window_size_when_changing_font_size = false

-- Using a patched MonoLisa
config.font = wezterm.font_with_fallback {
  'MonoLisa',
  'JetBrainsMono Nerd Font',
}

-- useful keyboards shortcuts I have come on to rely
config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'm',
    mods = 'SUPER',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'k',
    mods = 'SUPER',
    action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
  },

  -- Navigation between tabs
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = 'LeftArrow', mods = 'SHIFT | SUPER', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'SHIFT | SUPER', action = wezterm.action.ActivateTabRelative(1) },

  -- Navigation between panes
  {
    key = 'LeftArrow',
    mods = 'SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
    -- This will create a new split and run your default program inside it
  {
    key = 'p',
    mods = 'SHIFT|SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

-- needed for french keyboards to work properly
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- config.debug_key_events = true

-- and finally, return the configuration to wezterm
return config
