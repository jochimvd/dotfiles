hl.layer_rule({
    match = { namespace = "varde" },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.1,
})

hl.layer_rule({
    match = { namespace = "varde-launcher" },
    blur = true,
    ignore_alpha = 0.1,
})

hl.layer_rule({
    match = { namespace = "varde-notification-popups" },
    blur = true,
    ignore_alpha = 0.1,
    no_screen_share = true,
    animation = "slide right",
})
