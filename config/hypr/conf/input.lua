-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",

        follow_mouse = 1,
        -- follow_mouse_threshold = 5,

        accel_profile = "flat",
        sensitivity = 0,

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            clickfinger_behavior = true,
        },
    },

    cursor = {
        no_warps = true,
        persistent_warps = true,
        warp_on_change_workspace = 0,
        -- warp_on_monitor_change = 2,
        warp_on_toggle_special = 0,
        inactive_timeout = 5,
    },

    binds = {
        hide_special_on_workspace_change = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Basics/Variables/#per-device-input-configs
hl.device({
    name = "synps/2-synaptics-touchpad",
    sensitivity = 0.8,
})

hl.device({
    name = "tpps/2-elan-trackpoint",
})
