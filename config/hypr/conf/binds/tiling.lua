-- Close windows
hl.bind("SUPER + Q",         hl.dsp.window.close(), { description = "Close active window" })
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill(),  { description = "Force close active window" })

-- Tiling
hl.bind("SUPER + P",        hl.dsp.window.pseudo(),                                                       { description = "Pseudo tile window" })
hl.bind("SUPER + T",        hl.dsp.window.float({ action = "toggle" }),                                   { description = "Toggle floating/tiling" })
hl.bind("SUPER + Z",        hl.dsp.layout("togglesplit"),                                                 { description = "Toggle window split" })
hl.bind("SUPER + A",        hl.dsp.layout("movetoroot active"),                                           { description = "Move window to root" })
hl.bind("SUPER + O",        hl.dsp.exec_cmd("dot-hyprland-overlay-window"),                               { description = "Overlay window (float & pin)" })
hl.bind("SUPER + F",        hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),         { description = "Toggle fullscreen" })
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "set" }), { description = "Tiled full screen" })

local dirs = {
    { keys = { "h", "LEFT" },  dir = "left" },
    { keys = { "j", "DOWN" },  dir = "down" },
    { keys = { "k", "UP" },    dir = "up" },
    { keys = { "l", "RIGHT" }, dir = "right" },
}

-- Move focus
for _, d in ipairs(dirs) do
    for _, k in ipairs(d.keys) do
        hl.bind("SUPER + " .. k, hl.dsp.focus({ direction = d.dir }),
            { description = "Move focus " .. d.dir })
    end
end

-- Swap windows (within layout)
for _, d in ipairs(dirs) do
    for _, k in ipairs(d.keys) do
        hl.bind("SUPER + SHIFT + " .. k, hl.dsp.window.swap({ direction = d.dir }),
            { description = "Swap window " .. d.dir })
    end
end

-- Move windows (across containers)
for _, d in ipairs(dirs) do
    for _, k in ipairs(d.keys) do
        hl.bind("SUPER + SHIFT + ALT + " .. k, hl.dsp.window.move({ direction = d.dir }),
            { description = "Move window " .. d.dir })
    end
end

-- Resize windows
local resize_steps = {
    { keys = { "h", "LEFT" },  x = -80, y = 0 },
    { keys = { "j", "DOWN" },  x = 0,   y = 80 },
    { keys = { "k", "UP" },    x = 0,   y = -80 },
    { keys = { "l", "RIGHT" }, x = 80,  y = 0 },
}
for _, d in ipairs(resize_steps) do
    for _, k in ipairs(d.keys) do
        hl.bind("SUPER + CTRL + " .. k,
            hl.dsp.window.resize({ x = d.x, y = d.y, relative = true }),
            { repeating = true, description = "Resize window" })
    end
end

-- Workspaces 1-10 (key '0' maps to workspace 10)
for i = 1, 10 do
    local key = (i == 10) and "0" or tostring(i)
    hl.bind("SUPER + "               .. key, hl.dsp.focus({ workspace = i }),                       { description = "Switch to workspace " .. i })
    hl.bind("SUPER + SHIFT + "       .. key, hl.dsp.window.move({ workspace = i }),                 { description = "Move window to workspace " .. i })
    hl.bind("SUPER + SHIFT + ALT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }), { description = "Move window to workspace " .. i .. " (silent)" })
end

-- Move current workspace to next/previous monitor
hl.bind("SUPER + N",         hl.dsp.workspace.move({ monitor = "+1" }), { description = "Move workspace to next monitor" })
hl.bind("SUPER + SHIFT + N", hl.dsp.workspace.move({ monitor = "-1" }), { description = "Move workspace to previous monitor" })

-- Special workspace (scratchpad)
hl.bind("SUPER + S",               hl.dsp.workspace.toggle_special("scratchpad"),                            { description = "Toggle scratchpad" })
hl.bind("SUPER + SHIFT + S",       hl.dsp.window.move({ workspace = "special:scratchpad" }),                 { description = "Move window to scratchpad" })
hl.bind("SUPER + SHIFT + ALT + S", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }), { description = "Move window to scratchpad (silent)" })

-- Scroll through workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll active worspace forward" })
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll active workspace backward" })

-- TAB between workspaces
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }), { description = "Previous workspace" })

-- Move/resize windows with SUPER + LMB/RMB drag
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true, description = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- Grouped window mode
hl.bind("SUPER + G",         hl.dsp.group.toggle(),                           { description = "Toggle window group" })
hl.bind("SUPER + ALT + G",   hl.dsp.window.move({ out_of_group = true }),     { description = "Move active window out of group" })
hl.bind("SUPER + SHIFT + G", hl.dsp.group.lock_active({ action = "toggle" }), { description = "Lock window group" })

-- Join groups
local into_group = {
    { key = "LEFT",  dir = "left",  label = "left" },
    { key = "DOWN",  dir = "down",  label = "bottom" },
    { key = "UP",    dir = "up",    label = "top" },
    { key = "RIGHT", dir = "right", label = "right" },
}
for _, d in ipairs(into_group) do
    hl.bind("SUPER + ALT + " .. d.key, hl.dsp.window.move({ into_group = d.dir }),
        { description = "Move window to group on " .. d.label })
end

-- Cycle through group members
hl.bind("SUPER + ALT + N",         hl.dsp.group.next(), { description = "Next window in group" })
hl.bind("SUPER + ALT + SHIFT + N", hl.dsp.group.prev(), { description = "Previous window in group" })

-- Scroll through grouped windows with SUPER + ALT + scroll
hl.bind("SUPER + ALT + mouse_down", hl.dsp.group.next(), { description = "Next window in group" })
hl.bind("SUPER + ALT + mouse_up",   hl.dsp.group.prev(), { description = "Previous window in group" })

-- Activate window in a group by number
for i = 1, 5 do
    hl.bind("SUPER + ALT + " .. i, hl.dsp.group.active({ index = i }),
        { description = "Switch to group window " .. i })
end
