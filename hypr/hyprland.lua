-- Migrated from hyprland.conf (hyprlang) to the Lua config format.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output            = "DP-1",
    mode              = "2560x1440@280.00",
    position          = "0x96",
    scale             = 1.00,
    bitdepth          = 10,
    cm                = "hdr",
    min_luminance     = 0.0,
    max_luminance     = 400,
    sdr_min_luminance = 0.0,
    sdr_max_luminance = 400,
})

hl.monitor({
    output    = "DP-2",
    mode      = "1920x1080@165.00",
    position  = "-1080x-320",
    scale     = 1.0,
    transform = 3,
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "hyprlauncher"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("caelestia shell -d")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprctl setcursor rose-pine-hyprcursor 24")

    -- hl.exec_cmd("swaync")
    -- hl.exec_cmd("hyprsunset")
    -- hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/sync-theme-from-hyprsunset.sh")
    -- hl.exec_cmd("nmcli connection up Hotspot")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("XDG_MENU_PREFIX", "arch-")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
-- hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
-- hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,

        border_size = 2,

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#variable-types for info about colors
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
        blur = {
            enabled  = false, -- temporarily disabled to test nvidia-drm atomic commit flicker
            size     = 10,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.config({
    animations = {
        enabled = true,
    },
})

-- Default curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},   {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05},{0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},      {1, 1}   } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},  {0.75, 1}} })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},   {0.1, 1} } })

-- Default animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

----------------
----  MISC  ----
----------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
        -- vrr = 1, -- causes flickers
        vrr = 0,
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#render
hl.config({
    render = {
        cm_auto_hdr    = true,
        direct_scanout = false, -- temporarily disabled to test nvidia-drm atomic commit flicker
    },
})


---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout  = "fr",
        kb_variant = "azerty",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod      = "SUPER" -- Sets "Windows" key as main modifier
local mainModShift = "SUPER + SHIFT"
local mainModCtrl  = "SUPER + CTRL"

hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"))

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainModShift .. " + A", hl.dsp.window.close())
hl.bind(mainModShift .. " + E", hl.dsp.exec_cmd(
    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
))
hl.bind(mainModShift .. " + Escape", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainModShift .. " + F", hl.dsp.window.float())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Space", hl.dsp.global("caelestia:launcher"))
hl.bind(mainModCtrl .. " + T", hl.dsp.window.pin())

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + V", hl.dsp.layout("preselect t")) -- dwindle
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle

-- go to next / previous workspace
hl.bind(mainModCtrl .. " + left",  hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainModCtrl .. " + right", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainModCtrl .. " + W", hl.dsp.exec_cmd("qs -c caelestia kill || qs -n -d -c caelestia"))
hl.bind(mainModCtrl .. " + V", hl.dsp.exec_cmd("caelestia shell nexus openPage audio 1"))
hl.bind(mainModCtrl .. " + P", hl.dsp.exec_cmd("pkill hyprpaper || hyprpaper"))

hl.bind(mainModCtrl .. " + N", hl.dsp.exec_cmd("qs -c caelestia ipc call drawers toggle sidebar"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces (AZERTY top-row symbols)
hl.bind(mainMod .. " + ampersand",   hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + eacute",      hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + quotedbl",    hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + apostrophe",  hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + parenleft",   hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + minus",       hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + egrave",      hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + underscore",  hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + ccedilla",    hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + agrave",      hl.dsp.focus({ workspace = "10" }))

-- Send to Workspaces
hl.bind(mainModShift .. " + ampersand",   hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainModShift .. " + eacute",      hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainModShift .. " + quotedbl",    hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainModShift .. " + apostrophe",  hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainModShift .. " + parenleft",   hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainModShift .. " + minus",       hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainModShift .. " + egrave",      hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainModShift .. " + underscore",  hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainModShift .. " + ccedilla",    hl.dsp.window.move({ workspace = "9" }))
hl.bind(mainModShift .. " + agrave",      hl.dsp.window.move({ workspace = "10" }))

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainModShift .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Switch to a submap called `resize`.
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

-- Define the "resize" submap. Set repeatable binds for resizing the active window.
hl.define_submap("resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
    hl.bind("left",  hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
    hl.bind("up",    hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
    hl.bind("down",  hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })

    -- Use `reset` to go back to the global submap
    hl.bind("escape",         hl.dsp.submap("reset"))
    hl.bind(mainMod .. " + R", hl.dsp.submap("reset"))
end)

-- Toggle Hyprsunset + app dark preference (day/night)
-- hl.bind(mainModShift .. " + N", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/toggle-hyprsunset.sh"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

-- Example windowrules that are useful

-- PiP tuning variables
local pipW      = 427
local pipH      = 240
local pipMargin = 20

-- Chromium PiP: force floating 16:9 window in bottom-right corner
hl.window_rule({
    name  = "chromium-pip",
    match = { initial_title = "^(Picture in picture|Picture-in-Picture)$" },

    float = true,
    pin   = true,
    size  = pipW .. " " .. pipH,
    move  = "monitor_w-" .. pipW .. "-" .. pipMargin .. " monitor_h-" .. pipH .. "-" .. pipMargin .. "-40",
})

hl.workspace_rule({ workspace = "1",  monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "2",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "3",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "4",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "5",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "6",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "7",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "8",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "9",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "10", monitor = "DP-1", default = true })

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
