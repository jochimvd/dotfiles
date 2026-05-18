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
        hide_on_key_press = true,
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
