local mode = require("conf.binds.modes")

hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close", submap_universal = true })
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }), { description = "Floating", submap_universal = true })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Full width", submap_universal = true })
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Fullscreen", submap_universal = true })

-- Shared descriptions group directional bindings and their arrow aliases.
for key, d in mode.direction_keys() do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = d.direction }), { description = "Focus", repeating = true, submap_universal = true })
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = d.direction }), { description = "Swap", submap_universal = true })
end

mode.enter("SUPER + W", "Window")
mode.define("Window", function(bind)
    for key, d in mode.direction_keys() do
        bind(key, hl.dsp.window.move({ direction = d.direction }), "Move", { stay = true, repeating = true })
    end
    bind("P", hl.dsp.window.pseudo(), "Pseudotile")
    bind("Z", hl.dsp.layout("togglesplit"), "Split orientation")
    bind("A", hl.dsp.layout("movetoroot active"), "Layout root")
    bind("O", hl.dsp.exec_cmd("dot-hyprland-overlay-window"), "Overlay")
    bind("F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }), "Tiled fullscreen")
    bind("S", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }), "Send to scratchpad")
    bind("SHIFT + Q", hl.dsp.window.kill(), "Force close")
end)

mode.enter("SUPER + R", "Resize")
mode.define("Resize", function(bind)
    for key, d in mode.direction_keys() do
        bind(key, hl.dsp.window.resize({ x = d.x * 80, y = d.y * 80, relative = true }), "Resize", { stay = true, repeating = true })
        bind("SHIFT + " .. key, hl.dsp.window.resize({ x = d.x * 20, y = d.y * 20, relative = true }), "Precise", { stay = true, repeating = true })
    end
end)

local function swap_current_workspace_with(target_id)
    return function()
        local source = hl.get_active_workspace()
        if not source or source.special or source.id == target_id then
            return
        end
        local source_id = source.id
        local target = hl.get_workspace(target_id)
        if not target then
            hl.dispatch(hl.dsp.workspace.change_id({ workspace = source, id = target_id }))
            return
        end
        local temporary_id = 4294967294
        while hl.get_workspace(temporary_id) do
            temporary_id = temporary_id - 1
        end
        hl.dispatch(hl.dsp.workspace.change_id({ workspace = source, id = temporary_id }))
        hl.dispatch(hl.dsp.workspace.change_id({ workspace = target, id = source_id }))
        hl.dispatch(hl.dsp.workspace.change_id({ workspace = source, id = target_id }))
    end
end

for key, id in mode.workspace_keys() do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = id }), { description = "Workspace", submap_universal = true })
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = id }), { description = "Move and follow", submap_universal = true })
end

mode.enter("SUPER + D", "Workspaces")
mode.define("Workspaces", function(bind)
    mode.cycle(bind, hl.dsp.focus({ workspace = "e-1" }), hl.dsp.focus({ workspace = "e+1" }))
    bind("TAB", hl.dsp.focus({ workspace = "previous" }), "Previous visited")
    for key, id in mode.workspace_keys() do
        bind(key, hl.dsp.focus({ workspace = id }), "Workspace")
    end
    mode.enter("M", "Workspaces / Move", "Move and follow…")
    mode.enter("S", "Workspaces / Send", "Send silently…")
    mode.enter("X", "Workspaces / Swap", "Swap workspaces…")
end)

local function define_workspace_mode(name, description, action_for)
    mode.define(name, function(bind)
        for key, id in mode.workspace_keys() do
            bind(key, action_for(id), description)
        end
    end)
end
define_workspace_mode("Workspaces / Move", "Move and follow", function(id)
    return hl.dsp.window.move({ workspace = id })
end)
define_workspace_mode("Workspaces / Send", "Send silently", function(id)
    return hl.dsp.window.move({ workspace = id, follow = false })
end)
define_workspace_mode("Workspaces / Swap", "Swap workspaces", swap_current_workspace_with)

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("scratchpad"), { description = "Scratchpad", submap_universal = true })
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad" }), { description = "Move to scratchpad", submap_universal = true })
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }), { description = "Previous workspace", submap_universal = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next occupied workspace" })
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous occupied workspace" })
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

mode.enter("SUPER + G", "Groups")
mode.define("Groups", function(bind)
    mode.cycle(bind, hl.dsp.group.prev(), hl.dsp.group.next())
    for i = 1, 5 do
        bind(tostring(i), hl.dsp.group.active({ index = i }), "Member")
    end
    for key, d in mode.direction_keys() do
        bind("SHIFT + " .. key, hl.dsp.window.move({ into_group = d.direction }), "Join group")
    end
    bind("G", hl.dsp.group.toggle(), "Toggle grouping")
    bind("U", hl.dsp.window.move({ out_of_group = true }), "Ungroup")
    bind("SHIFT + G", hl.dsp.group.lock_active({ action = "toggle" }), "Lock group")
end)
hl.bind("SUPER + ALT + mouse_down", hl.dsp.group.next(), { description = "Next group member" })
hl.bind("SUPER + ALT + mouse_up", hl.dsp.group.prev(), { description = "Previous group member" })

mode.enter("SUPER + O", "Outputs")
mode.define("Outputs", function(bind)
    for key, d in mode.direction_keys() do
        bind(key, hl.dsp.focus({ monitor = d.monitor }), "Focus monitor", { stay = true, repeating = true })
        bind("SHIFT + " .. key, hl.dsp.window.move({ monitor = d.monitor, follow = true }), "Move window")
    end
    mode.enter("W", "Outputs / Workspace", "Move workspace…")
end)
mode.define("Outputs / Workspace", function(bind)
    for key, d in mode.direction_keys() do
        bind(key, hl.dsp.workspace.move({ monitor = d.monitor }), "Move workspace")
    end
end)
