-- Mako notification blur
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, ignore_alpha = 0.1 })
hl.layer_rule({ match = { namespace = "notifications" }, no_screen_share = true })
hl.layer_rule({ match = { namespace = "notifications" }, animation = "slide right" })
