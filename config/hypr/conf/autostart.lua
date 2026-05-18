hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm-app -- walker --gapplication-service")
    hl.exec_cmd("uwsm-app -- wl-paste --watch cliphist store")

    -- Tray items
    hl.exec_cmd("uwsm-app -- udiskie --tray")
    hl.exec_cmd("uwsm-app -- 1password --silent")

    -- Activitywatch
    hl.exec_cmd("uwsm-app -- awatcher")

    -- Set cursor theme
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'")
end)
