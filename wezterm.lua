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

-- Overrides the cell background color when the current cell is occupied by the
-- -- cursor and the cursor style is set to Block
-- colors.cursor_bg = '#9893a5'
-- -- Overrides the text color when the current cell is occupied by the cursor
-- colors.cursor_fg = 'black'
-- -- Specifies the border color of the cursor when the cursor style is set to Block,
-- -- or the color of the vertical or horizontal bar when the cursor style is set to
-- -- Bar or Underline.
-- colors.cursor_border = '#9893a5'

config.colors = colors
config.window_frame = window_frame -- needed only if using fancy tab bar
config.window_background_opacity = 0.9


-- Using a patched MonoLisa
config.font = wezterm.font_with_fallback {
  'MonoLisa Nerd Font',
  'JuliaMono',
  'JetBrains Mono',
  'DengXian',
}

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
