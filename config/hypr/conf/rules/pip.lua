-- Picture-in-picture overlays
local pip_w, pip_h, margin = 600, 338, 40
hl.window_rule({ match = { title = "(Picture.?in.?[Pp]icture)" }, tag = "+pip" })
hl.window_rule({
    match = { tag = "pip" },
    float = true,
    pin = true,
    size = { pip_w, pip_h },
    keep_aspect_ratio = true,
    border_size = 0,
    opacity = "1 1",
    move = { ("monitor_w - %d"):format(pip_w + margin), "monitor_h * 0.04" },
})
