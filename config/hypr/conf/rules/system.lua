-- Floating windows
hl.window_rule({ match = { tag = "floating-window" }, float = true })
hl.window_rule({ match = { tag = "floating-window" }, center = true })
hl.window_rule({ match = { tag = "floating-window" }, size = { 875, 600 } })

-- Float and center settings, dialogs, ...
hl.window_rule({ match = { class = "(com.gabm.satty|imv|mpv)" }, tag = "+floating-window" })
hl.window_rule({
    match = {
        class = "(xdg-desktop-portal-gtk|org.gnome.Nautilus)",
        title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*|File Upload.*)",
    },
    tag = "+floating-window",
})
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true })
