local mode = require("conf.binds.modes")

-- Shared by the media keys and the Media mode.
local cmd = {
    volume_up           = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+",
    volume_down         = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
    volume_up_precise   = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+",
    volume_down_precise = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-",
    mute                = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
    mic_mute            = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
    stop                = "playerctl stop",
    play_pause          = "playerctl play-pause",
    next_track          = "playerctl next",
    previous_track      = "playerctl previous",
    brightness_up       = "brightnessctl -c backlight set 10%+",
    brightness_down     = "brightnessctl -c backlight set 10%-",
}

-- Media keys
hl.bind("XF86AudioRaiseVolume",         hl.dsp.exec_cmd(cmd.volume_up),
    { repeating = true, locked = true, submap_universal = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume",         hl.dsp.exec_cmd(cmd.volume_down),
    { repeating = true, locked = true, submap_universal = true, description = "Volume down" })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(cmd.volume_up_precise),
    { repeating = true, locked = true, submap_universal = true, description = "Volume up precise" })
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd(cmd.volume_down_precise),
    { repeating = true, locked = true, submap_universal = true, description = "Volume down precise" })

hl.bind("XF86AudioMute",    hl.dsp.exec_cmd(cmd.mute),     { locked = true, submap_universal = true, description = "Mute" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(cmd.mic_mute), { locked = true, submap_universal = true, description = "Mute microphone" })

hl.bind("XF86AudioStop", hl.dsp.exec_cmd(cmd.stop),           { locked = true, submap_universal = true, description = "Stop" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(cmd.play_pause),     { locked = true, submap_universal = true, description = "Play/Pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(cmd.next_track),     { locked = true, submap_universal = true, description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(cmd.previous_track), { locked = true, submap_universal = true, description = "Previous track" })

-- Monitor brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(cmd.brightness_up),
    { repeating = true, locked = true, submap_universal = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(cmd.brightness_down),
    { repeating = true, locked = true, submap_universal = true, description = "Brightness down" })

mode.enter("SUPER + M", "Media")
mode.define("Media", function(bind)
    bind("J", hl.dsp.exec_cmd(cmd.volume_down), "Volume down", { stay = true, repeating = true })
    bind("K", hl.dsp.exec_cmd(cmd.volume_up), "Volume up", { stay = true, repeating = true })
    bind("SHIFT + J", hl.dsp.exec_cmd(cmd.volume_down_precise), "Fine down", { stay = true, repeating = true })
    bind("SHIFT + K", hl.dsp.exec_cmd(cmd.volume_up_precise), "Fine up", { stay = true, repeating = true })
    bind("H", hl.dsp.exec_cmd(cmd.previous_track), "Previous track", { stay = true })
    bind("L", hl.dsp.exec_cmd(cmd.next_track), "Next track", { stay = true })
    bind("SPACE", hl.dsp.exec_cmd(cmd.play_pause), "Play/pause")
    bind("S", hl.dsp.exec_cmd(cmd.stop), "Stop")
    bind("M", hl.dsp.exec_cmd(cmd.mute), "Mute")
    bind("SHIFT + M", hl.dsp.exec_cmd(cmd.mic_mute), "Mute microphone")
    bind("CTRL + J", hl.dsp.exec_cmd(cmd.brightness_down), "Dimmer", { stay = true, repeating = true })
    bind("CTRL + K", hl.dsp.exec_cmd(cmd.brightness_up), "Brighter", { stay = true, repeating = true })
end)
