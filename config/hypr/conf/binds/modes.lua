local M = {}
local current = ""
local reset = hl.dsp.submap("reset")

-- Reset before launching an app or entering a blocking operation.
local function reset_then(action)
    return function()
        hl.dispatch(reset)
        return hl.dispatch(action)
    end
end

-- The help menu reads these edges because Lua dispatcher IDs hide their targets.
dot_submap_paths = {}

M.directions = {
    { keys = { "H", "LEFT" },  direction = "left",  monitor = "l", x = -1, y = 0 },
    { keys = { "J", "DOWN" },  direction = "down",  monitor = "d", x = 0, y = 1 },
    { keys = { "K", "UP" },    direction = "up",    monitor = "u", x = 0, y = -1 },
    { keys = { "L", "RIGHT" }, direction = "right", monitor = "r", x = 1, y = 0 },
}

-- `for key, d in mode.direction_keys() do`: every Vim key and arrow with its direction.
function M.direction_keys()
    return coroutine.wrap(function()
        for _, d in ipairs(M.directions) do
            for _, key in ipairs(d.keys) do
                coroutine.yield(key, d)
            end
        end
    end)
end

-- `for key, id in mode.workspace_keys() do`: number row keys 1-9, then 0 for workspace 10.
function M.workspace_keys()
    return coroutine.wrap(function()
        for id = 1, 10 do
            coroutine.yield((id == 10) and "0" or tostring(id), id)
        end
    end)
end

-- Binds H/LEFT to `previous` and L/RIGHT to `next`, staying in the mode.
function M.cycle(bind, previous, next)
    for key, d in M.direction_keys() do
        if d.x ~= 0 then
            bind(key, d.x < 0 and previous or next, d.x < 0 and "Previous" or "Next", { stay = true, repeating = true })
        end
    end
end

-- Works in every mode, leaving it first so the action gets the keyboard.
function M.universal(keys, action, description)
    hl.bind(keys, reset_then(action), { description = description, submap_universal = true })
end

function M.enter(keys, name, description)
    dot_submap_paths[name] = { parent = current, key = keys }
    hl.bind(keys, hl.dsp.submap(name), {
        description = description or name,
        submap_universal = current == "",
    })
end

function M.define(name, configure)
    local parent = current
    current = name
    hl.define_submap(name, function()
        local function bind(keys, action, description, options)
            options = options or {}
            local bind_options = { description = description }
            for option, value in pairs(options) do
                if option ~= "stay" then
                    bind_options[option] = value
                end
            end
            hl.bind(keys, options.stay and action or reset_then(action), bind_options)
        end
        configure(bind)
        hl.bind("ESCAPE", reset, { description = "Exit" })
        hl.bind("RETURN", reset, { description = "Exit" })
        -- Lua catchalls can also run after a matching bind in Hyprland 0.56.
        -- Ignore unbound keys without cancelling a staying action or nested mode.
        hl.bind("catchall", function() end)
    end)
    current = parent
end

return M
