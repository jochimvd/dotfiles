hl.window_rule({
    -- Match both the legacy class and the native Wayland app ID.
    match = { class = "^(1[pP]assword|com[.]onepassword[.]OnePassword)$" },
    no_screen_share = true,
    tag = "+floating-window",
})
