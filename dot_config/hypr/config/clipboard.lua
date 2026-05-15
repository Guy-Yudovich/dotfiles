-----------------
--- CLIPBOARD ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("clipse -listen")
end)

hl.window_rule({
    name  = "clipboard-float",
    match = { class = Clip },
    float = true,
})
