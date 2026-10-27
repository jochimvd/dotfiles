hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm-app -- wl-paste --watch cliphist store")

    -- Tray items
    hl.exec_cmd("uwsm-app -- udiskie --tray")
    hl.exec_cmd("uwsm-app -- 1password --silent")
end)
