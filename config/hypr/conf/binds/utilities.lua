-- Menus
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("walker"),              { description = "App launcher" })
hl.bind("SUPER + E",     hl.dsp.exec_cmd("walker -m symbols"),   { description = "Emoji menu" })
hl.bind("SUPER + V",     hl.dsp.exec_cmd("walker -m clipboard"), { description = "Clipboard menu" })
hl.bind("SUPER + SLASH", hl.dsp.exec_cmd("dot-menu-keybinds"),   { description = "Keybinds menu" })

-- Session/power options
hl.bind("SUPER + ESCAPE",         hl.dsp.exec_cmd("dot-menu-power"),     { description = "Power menu" })
hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.exec_cmd("dot-cmd-lockscreen"), { description = "Lock screen" })
hl.bind("SUPER + CTRL + ESCAPE",  hl.dsp.exec_cmd("systemctl suspend"),  { release = true, description = "Suspend" })

-- Screenshots
hl.bind("PRINT",         hl.dsp.exec_cmd("dot-cmd-screenshot"),                 { description = "Screenshot" })
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("dot-cmd-screenshot smart clipboard"), { description = "Screenshot to clipboard" })

-- Screen recording
hl.bind("ALT + PRINT",        hl.dsp.exec_cmd("dot-cmd-screenrecord"),        { description = "Screen record a region" })
hl.bind("CTRL + ALT + PRINT", hl.dsp.exec_cmd("dot-cmd-screenrecord output"), { description = "Screen record display" })

-- Color picker
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"), { description = "Color picker" })
