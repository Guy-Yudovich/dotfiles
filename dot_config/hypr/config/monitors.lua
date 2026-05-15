----------------
--- MONITORS ---
----------------

-- See https://wiki.hypr.land/Configuring/Monitors/

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto-center-down",
    scale    = 1,
})

hl.monitor({
    output              = "desc: Microstep MSI G32CQ4 E2",
    mode                = "2560x1440@165",
    position            = "1920x275",
    scale               = "auto",
    supports_wide_color = 1,
    supports_hdr        = 1,
    -- cm               = "hdr", -- un/comment to toggle HDR
    bitdepth            = 10,
    sdrbrightness       = 1.25,
    sdrsaturation       = 1.2,
})

hl.monitor({
    output    = "desc: LG Electronics LG ULTRAGEAR 0x0000010C",
    mode      = "1920x1080@165",
    position  = "4480x0",
    scale     = "auto",
    transform = 3,
})

hl.monitor({
    output   = "desc: LG Electronics LG ULTRAGEAR 0x0000010E",
    mode     = "1920x1080@165",
    position = "0x635",
    scale    = "auto",
})

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto-center-up",
    scale    = "auto",
})
