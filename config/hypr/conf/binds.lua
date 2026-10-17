local prog = require("conf.programs")
local mode = require("conf.binds.modes")

mode.universal("SUPER + RETURN", hl.dsp.exec_cmd("uwsm-app -- " .. prog.terminal), "Terminal")

mode.enter("SUPER + E", "Apps")
mode.define("Apps", function(bind)
    bind("T", hl.dsp.exec_cmd("uwsm-app -- " .. prog.terminal), "Terminal")
    bind("F", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window"), "Files")
    bind("B", hl.dsp.exec_cmd("uwsm-app -- " .. prog.browser), "Browser")
    bind("W", hl.dsp.exec_cmd("uwsm-app -- " .. prog.browser .. " -P 'Work'"), "Work browser")
    bind("M", hl.dsp.exec_cmd("uwsm-app -- spotify-launcher"), "Spotify")
    bind("O", hl.dsp.exec_cmd("uwsm-app -- obsidian"), "Obsidian")
    bind("P", hl.dsp.exec_cmd("uwsm-app -- 1password"), "1Password")
end)

require("conf.binds.utilities")
require("conf.binds.tiling")
require("conf.binds.media")
