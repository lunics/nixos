hl.window_rule({ -- Fix some dragging issues with XWayland
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

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

local terminal  = "Alacritty|Kitty|com.mitchellh.ghostty"
local browser   = "firefox|librewolf|zen-twilight|zen-beta"
local message   = "discord|org.gajim.Gajim|Element|Session|org.telegram.dekstop|info.mumble.Mumble"
local streaming = "spotify|FreeTube|streamlink-twitch-gui|mpv"
local music     = "org.musescore.MuseScore"
local libvirt   = "virt-viewer"
local all       = "$terminal|$browser|$message|$streaming|$gaming|$music|$libvirt"

hl.window_rule({
  name      = "default-workspace-terminal",
  match     = { class = terminal },
  workspace = 1,
})

hl.window_rule({
  name      = "default-workspace-browser",
  match     = { class = browser },
  workspace = 2,
})

hl.window_rule({
  name        = "no-broders-for-brower",
  match       = { class = browser },
  border_size = 0,
})

-- windowrule = maximize on, match:class $all
-- windowrule = move 6 52, class:.*
-- windowrule = size 99.4% 95%, class:.*
-- windowrule = size 1908 1142, class:.*     # 1920-, 1200-

-- windowrule = workspace 3,     match:class $message
-- windowrule = workspace 4,     match:class $streaming, title:^($streaming)
--
-- windowrule = float,        class:^(udiskie)$
-- windowrule = move 40% 40%, class:^(udiskie)$
-- windowrule = size 500 400, class:^(udiskie)$
