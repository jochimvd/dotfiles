local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font({ family = "JetBrainsMono Nerd Font", scale = 1.2 })
config.color_scheme = "Catppuccin Mocha"

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 5000

config.window_decorations = "TITLE | RESIZE"

config.enable_wayland = false

return config
