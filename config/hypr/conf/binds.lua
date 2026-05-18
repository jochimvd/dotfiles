-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local prog = require("conf.programs")

-- Browser submap. `define_submap("name", "reset", fn)` auto-resets to the
-- "reset" submap after any bind inside fires.
hl.bind("SUPER + SHIFT + B", hl.dsp.submap("browser"), { description = "Web browser submap" })

hl.define_submap("browser", "reset", function()
    hl.bind("P", hl.dsp.exec_cmd("uwsm-app -- " .. prog.browser),
        { description = "Main browser" })
    hl.bind("W", hl.dsp.exec_cmd("uwsm-app -- " .. prog.browser .. " -P 'Work'"),
        { description = "Work browser" })
    hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- App launchers
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window"), { description = "Files" })
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("uwsm-app -- spotify-launcher"),      { description = "Spotify" })
hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("uwsm-app -- obsidian"),              { description = "Obsidian" })
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("uwsm-app -- 1password"),             { description = "1Password" })
hl.bind("SUPER + RETURN",    hl.dsp.exec_cmd("uwsm-app -- " .. prog.terminal),     { description = "Terminal" })

require("conf.binds.utilities")
require("conf.binds.tiling")
require("conf.binds.media")
