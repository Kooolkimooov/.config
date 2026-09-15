-- Hyprland config for the hyprlogin greeter session.
-- greetd runs this as the `greeter` user; set_config installs it to
-- /etc/hyprlogin/hyprland-greeter.lua.
--
-- Only what must differ from Hyprland's defaults lives here. The desktop's monitor
-- modes, HDR and cursor theme are deliberately not duplicated from hyprland.lua.

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprlogin")
end)

-- DP-2 is physically rotated; without this the greeter renders sideways on it.
hl.monitor({
    output   = "DP-2",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
    transform = 3,
})

hl.config({
    input = {
        kb_layout  = "fr", -- the password is typed here: keep in sync with hyprland.lua
        kb_variant = "azerty",
    },
})
