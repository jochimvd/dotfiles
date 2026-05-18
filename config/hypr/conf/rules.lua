-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Prevent windows from being maximized
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- App-specific rules. Slash-form path because Lua module identifiers
-- cannot start with a digit (1password).
require("conf/rules/1password")
require("conf/rules/chromium")
require("conf/rules/pip")
require("conf/rules/runelite")
require("conf/rules/selection")
require("conf/rules/sidecar")
require("conf/rules/swaync")
require("conf/rules/system")
require("conf/rules/walker")
require("conf/rules/waybar")
