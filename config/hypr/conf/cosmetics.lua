-- See https://wiki.hypr.land/Configuring/Variables/

local active_border   = "rgba(FFFFFFee)"
local inactive_border = "rgba(595959ee)"

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        col = {
            active_border   = active_border,
            inactive_border = inactive_border,
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    group = {
        col = {
            border_active            = active_border,
            border_inactive          = inactive_border,
            border_locked_active     = active_border,
            border_locked_inactive   = inactive_border,
        },
        groupbar = {
            blur = true,
            height = 0,
            gaps_in = 4,
            gaps_out = 4,
            keep_upper_gap = false,
            indicator_gap = 0,
            indicator_height = 10,
            col = {
                active   = active_border,
                inactive = inactive_border,
            },
            rounding = 5,
            round_only_edges = true,
            gradients = false,
        },
    },

    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        blur = {
            enabled = true,
            size = 8,
            passes = 2,
        },
        shadow = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        focus_on_activate = true,
        anr_missed_pings = 5,
    },

    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})

-- Disable the entire animation tree, then re-enable only fadeLayersIn
hl.animation({ leaf = "global",       enabled = false })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "default" })
