-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({ output = "",                                                mode = "preferred",       position = "auto",         scale = 1 })
hl.monitor({ output = "desc:BOE 0x09DC",                                 mode = "1920x1080@60",    position = "0x0",          scale = 1 }) -- Laptop
hl.monitor({ output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. M28U",         mode = "3840x2160@120",   position = "-960x-2160",   scale = 1, vrr = 1 })

-- B2 screens
hl.monitor({ output = "desc:Samsung Electric Company S24C650",           mode = "preferred",       position = "0x-1200",      scale = 1 })
hl.monitor({ output = "desc:AOC 2490W1",                                 mode = "preferred",       position = "0x-1080",      scale = 1 })

-- AC screens (4k)
hl.monitor({ output = "desc:Dell Inc. DELL U3223QE",                     mode = "preferred",       position = "-960x-2160",   scale = 1 })
hl.monitor({ output = "desc:Dell Inc. DELL U3219Q",                      mode = "preferred",       position = "-960x-2160",   scale = 1 })

-- AC screens (Ultrawide)
hl.monitor({ output = "desc:Dell Inc. DELL U3419W",                      mode = "preferred",       position = "-760x-1440",   scale = 1 })
hl.monitor({ output = "desc:Dell Inc. DELL U3421WE",                     mode = "preferred",       position = "-760x-1440",   scale = 1 })

-- Laptop Lid Switch
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("lid-state lid-closed"), { locked = true })
hl.bind("switch:off:Lid Switch", function()
    hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
end, { locked = true })

-- Catches the boot/wake case where the lid was already shut at Hyprland start.
hl.on("config.reloaded", function()
    hl.exec_cmd("lid-state")
end)
