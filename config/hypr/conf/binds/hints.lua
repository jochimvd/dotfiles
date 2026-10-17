-- Shows each mode's keys in Varde's titlebar. The hint is built once at load,
-- so entering a mode only spawns one D-Bus call to Varde's `title-set` action.
local M = {}

local ITEMS_DELAY_MS = 300
local VARDE = "busctl --user call org.varde.desktop /org/varde/desktop org.gtk.Actions Activate 'sava{sv}' "
local MODIFIERS = {
    { names = { SUPER = true, WIN = true, LOGO = true }, label = "Super" },
    { names = { CTRL = true, CONTROL = true }, label = "Ctrl" },
    { names = { ALT = true }, label = "Alt" },
    { names = { SHIFT = true }, label = "Shift" },
}
local KEY_NAMES = {
    LEFT = "←", DOWN = "↓", UP = "↑", RIGHT = "→",
    ESCAPE = "Esc", RETURN = "Enter", SPACE = "Space", TAB = "Tab",
}

local recorded = {}
local commands = {}
local seq = 0

local function shell_quote(text)
    return "'" .. text:gsub("'", "'\\''") .. "'"
end

local function json_string(text)
    return '"' .. text:gsub('[%c"\\]', function(char)
        return char == '"' and '\\"' or char == "\\" and "\\\\" or string.format("\\u%04x", char:byte())
    end) .. '"'
end

-- "SHIFT + H" -> "Shift", "H"
local function parse_keys(keys)
    local parts = {}
    for part in keys:gmatch("[^+]+") do
        parts[#parts + 1] = part:match("^%s*(.-)%s*$"):upper()
    end
    local key = table.remove(parts)
    local mods = {}
    for _, modifier in ipairs(MODIFIERS) do
        for _, part in ipairs(parts) do
            if modifier.names[part] then
                mods[#mods + 1] = modifier.label
                break
            end
        end
    end
    return table.concat(mods, "+"), key
end

-- Collapses aliases: HJKL -> hjkl, arrows -> ←↓↑→, three or more consecutive digits -> 1–9.
local function key_set_name(keys)
    local remaining, has = {}, {}
    for _, key in ipairs(keys) do
        remaining[#remaining + 1] = key
        has[key] = true
    end
    local names = {}
    local function take(set)
        for _, key in ipairs(set) do
            if not has[key] then
                return false
            end
        end
        local drop = {}
        for _, key in ipairs(set) do
            drop[key] = true
        end
        local kept = {}
        for _, key in ipairs(remaining) do
            if not drop[key] then
                kept[#kept + 1] = key
            end
        end
        remaining = kept
        return true
    end
    if take({ "H", "J", "K", "L" }) then
        names[#names + 1] = "hjkl"
    end
    if take({ "LEFT", "DOWN", "UP", "RIGHT" }) then
        names[#names + 1] = "←↓↑→"
    end
    local digits = {}
    for _, key in ipairs(remaining) do
        if key:match("^[1-9]$") then
            digits[#digits + 1] = tonumber(key)
        end
    end
    table.sort(digits)
    local contiguous = #digits >= 3
    for i = 2, #digits do
        contiguous = contiguous and digits[i] == digits[i - 1] + 1
    end
    if contiguous then
        local set = {}
        for i, digit in ipairs(digits) do
            set[i] = tostring(digit)
        end
        take(set)
        names[#names + 1] = digits[1] .. "–" .. digits[#digits]
    end
    for _, key in ipairs(remaining) do
        names[#names + 1] = KEY_NAMES[key] or (#key == 1 and key:lower()) or key
    end
    return table.concat(names, "/")
end

function M.record(submap, keys, description, options)
    options = options or {}
    local mods, key = parse_keys(keys)
    recorded[submap] = recorded[submap] or {}
    table.insert(recorded[submap], {
        mods = mods,
        key = key,
        description = description or "",
        release = options.release == true,
        long_press = options.long_press == true,
    })
end

-- Binds sharing a description, modifiers and trigger type become one item.
function M.build(submap)
    local groups = {}
    for _, bind in ipairs(recorded[submap] or {}) do
        local group
        if bind.description ~= "" then
            for _, existing in ipairs(groups) do
                local first = existing.bind
                if first.description == bind.description and first.mods == bind.mods
                    and first.release == bind.release and first.long_press == bind.long_press then
                    group = existing
                    break
                end
            end
        end
        if group then
            local seen = false
            for _, key in ipairs(group.keys) do
                seen = seen or key == bind.key
            end
            if not seen then
                group.keys[#group.keys + 1] = bind.key
            end
        else
            groups[#groups + 1] = { bind = bind, keys = { bind.key } }
        end
    end

    local items = {}
    for _, group in ipairs(groups) do
        local key = key_set_name(group.keys)
        if group.bind.mods ~= "" then
            key = group.bind.mods .. "+" .. key
        end
        local description = group.bind.description
        local pinned = description == "Exit" or description == "Cancel"
        items[#items + 1] = string.format('{"key":%s,"label":%s,"pinned":%s}',
            json_string(key), json_string(description), tostring(pinned))
    end
    local json = string.format('{"version":1,"id":"submap","icon":"󰌌","text":%s,"items_delay_ms":%d,"items":[%s]}',
        json_string(submap), ITEMS_DELAY_MS, table.concat(items, ","))
    commands[submap] = shell_quote(json)
end

-- `seq` only grows, even across config reloads, so Varde can drop calls that arrive out of order.
hl.on("keybinds.submap", function(name)
    seq = math.max(seq + 1, os.time() * 1000000)
    local json = commands[name]
    local action = json and "title-set" or "title-clear"
    hl.exec_cmd(VARDE .. action .. " 1 '(ts)' " .. seq .. " " .. (json or "submap") .. " 0")
end)

return M
