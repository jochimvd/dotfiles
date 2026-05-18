-- Fix RuneLite popups
hl.window_rule({
    match = {
        initial_class = "net-runelite-launcher-Launcher",
        initial_title = "RuneLite",
    },
    pseudo = true,
})

hl.window_rule({
    match = {
        float = true,
        initial_class = "net-runelite-launcher-Launcher",
        initial_title = "^win(.*)",
    },
    no_focus = true,
})
