-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Default scratchpad windows to floating, both when opened and moved there
hl.window_rule({ match = { workspace = "special:scratchpad" }, float = true })
hl.on("window.move_to_workspace", function(window, workspace)
    if workspace.name == "special:scratchpad" and not window.floating then
        hl.dispatch(hl.dsp.window.float({ window = window, action = "set" }))
    end
end)

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
require("conf/rules/system")
require("conf/rules/varde")
