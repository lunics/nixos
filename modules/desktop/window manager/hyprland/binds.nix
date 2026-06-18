{
  flake.aspects.window_manager.homeManager = { config, ... }:
  let
    _hypr = config._.hyprland;
  in {
    wayland.windowManager.hyprland.extraLuaFiles.binds.content = ''
      hl.config({
        binds = {
          allow_workspace_cycles = true,
        },
      })

      -- keys: SHIFT CAPS CTRL/CONTROL ALT MOD2 MOD3 SUPER/WIN/LOGO/MOD4 MOD5
      local SUPER  = "SUPER"
      local SSHIFT = "SUPER + SHIFT"

      local bind = {
        { "${_hypr.toggle_bt}",  hl.dsp.exec_cmd(toggle_bt_device 90:5F:7A:BC:93:87), },
        { "${_hypr.toggle_bar}", hl.dsp.exec_cmd(hyprpanel toggleWindow bar-0), },
        -- bindr = $SUPER, SUPER_L, exec, ulauncher-toggle
        { SUPER  .. " + F",     hl.dsp.window.float({ action = "toggle" }), },
        { SUPER  .. " + L",     hl.dsp.exec_cmd(swaylock), },
        { SUPER  .. " + M",     hl.dsp.exec_cmd(hyprctl dispatch dpms toggle eDP-1), },
        { SUPER  .. " + P",     hl.dsp.exec_cmd(toggle_pomodoro), },
        { SUPER  .. " + Q",     hl.dsp.window.close(), },
        -- remove after task 69 done: bind  = $SUPER,     R, exec, pkill wofi || (export PATH="$HOME/.local/share/devbox/global/default/.devbox/nix/profile/default/bin:$PATH" && echo $PATH > $HOME/test.log && wofi)
        { SUPER  .. " + ${_hypr.suspend}", hl.dsp.exec_cmd(save_env & systemctl suspend), },
        { SSHIFT .. " + ${_hypr.suspend}", hl.dsp.exec_cmd(save_env & systemctl suspend & swaylock), },
        -- { SUPER .. " + F11", hl.dsp.exec_cmd(sudo -A systemctl suspend && swaylock), },
        { SUPER  .. " + R",     hl.dsp.exec_cmd(pkill wofi || wofi), },
        { SUPER  .. " + S",     hl.dsp.exec_cmd(grimblast --notify copysave area ${config._.share}/screenshots/$(date +"%d-%m-%Y%H-%M-%S").png), },
        { SUPER  .. " + T",     hl.dsp.exec_cmd(alacritty), },
        { SSHIFT .. " + T",     hl.dsp.exec_cmd(alacritty --title terminal_floats), },
        { SUPER  .. " + V",     hl.dsp.exec_cmd(toggle_vpn), },

        -- WINDOWS --
        -- { SUPER  .. " + H",  hl.dsp.focus(left window), },
        -- { SUPER  .. " + L",  hl.dsp.focus(right window), },
        { SUPER  .. " + left",  hl.dsp.focus({ direction = "left"  }), },
        { SUPER  .. " + right", hl.dsp.focus({ direction = "right" }), },
        { SUPER  .. " + up",    hl.dsp.focus({ direction = "up"    }), },
        { SUPER  .. " + down",  hl.dsp.focus({ direction = "down"  }), },
        { SUPER  .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }, }, -- super + left click  = move window
        { SUPER  .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }, }, -- super + right click = resize window

        -- WORKSPACES --
        
        { SUPER  .. " + ${_hypr.prev_workspace}", hl.dsp.focus({ last }), },
        { SUPER  .. " + space",                   hl.dsp.focus({ last }), },
        -- bind = , ${_hypr.prev_workspace}, workspace, previous
        -- bind = SUPER, space, workspace, previous
        -- bindr = SUPER, SUPER_L, workspace, previous

        -- special workspace (scratchpad)
        { SSHIFT .. " + S",        hl.dsp.workspace.toggle_special("magic"), },
        { SSHIFT .. " + CTRL + S", hl.dsp.window.move({ workspace = "special:magic" }), },
        -- scroll through workspaces with SUPER + scroll
        { SUPER  .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), },
        { SUPER  .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), },

        -- focus workspace [0-9]
        { SUPER  .. " + ${_hypr.workspace."1"}", hl.dsp.focus({ workspace = 1 }),  },
        { SUPER  .. " + ${_hypr.workspace."2"}", hl.dsp.focus({ workspace = 2 }),  },
        { SUPER  .. " + ${_hypr.workspace."3"}", hl.dsp.focus({ workspace = 3 }),  },
        { SUPER  .. " + ${_hypr.workspace."4"}", hl.dsp.focus({ workspace = 4 }),  },
        { SUPER  .. " + ${_hypr.workspace."5"}", hl.dsp.focus({ workspace = 5 }),  },
        { SUPER  .. " + ${_hypr.workspace."6"}", hl.dsp.focus({ workspace = 6 }),  },
        { SUPER  .. " + ${_hypr.workspace."7"}", hl.dsp.focus({ workspace = 7 }),  },
        { SUPER  .. " + ${_hypr.workspace."8"}", hl.dsp.focus({ workspace = 8 }),  },
        { SUPER  .. " + ${_hypr.workspace."9"}", hl.dsp.focus({ workspace = 9 }),  },
        { SUPER  .. " + agrave",                 hl.dsp.focus({ workspace = 10 }), },

        -- move active window to workspace [0-9]
        { SSHIFT .. " + ${_hypr.workspace."1"}", hl.dsp.window.move({ workspace = 1 }),  },
        { SSHIFT .. " + ${_hypr.workspace."2"}", hl.dsp.window.move({ workspace = 2 }),  },
        { SSHIFT .. " + ${_hypr.workspace."3"}", hl.dsp.window.move({ workspace = 3 }),  },
        { SSHIFT .. " + ${_hypr.workspace."4"}", hl.dsp.window.move({ workspace = 4 }),  },
        { SSHIFT .. " + ${_hypr.workspace."5"}", hl.dsp.window.move({ workspace = 5 }),  },
        { SSHIFT .. " + ${_hypr.workspace."6"}", hl.dsp.window.move({ workspace = 6 }),  },
        { SSHIFT .. " + ${_hypr.workspace."7"}", hl.dsp.window.move({ workspace = 7 }),  },
        { SSHIFT .. " + ${_hypr.workspace."8"}", hl.dsp.window.move({ workspace = 8 }),  },
        { SSHIFT .. " + ${_hypr.workspace."9"}", hl.dsp.window.move({ workspace = 9 }),  },
        { SSHIFT .. " + agrave",                 hl.dsp.window.move({ workspace = 10 }), },

        -- audio
        { "XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true }, }, -- -l 2 = 200% max
        { "XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true }, },
        { "XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true }, },
        { "XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true }, },
        { "XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),       { locked = true }, },
        { "XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"), { locked = true }, },
        { "XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true }, },
        { "XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),   { locked = true }, },

        -- brightness
        { "XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true }, },
        { "XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true }, },
      }

      -- bind = $SUPER,    P,      pseudo,            # dwindle  KO
      -- bind = $SUPER,    P,      pin, active        # pin the current window across all workspaces
      -- bind = $SSHIFT,     BACKSPACE, movetoworkspace, special       # move active window to the special workspace
      -- bind = $SUPER,      BACKSPACE, togglespecialworkspace         # toggle pin the special workspace on top of the current workspace
      -- # bind = $SUPER,    Z, togglesplit,             # KO togglesplit doesn't exist anymore
      -- # bind = $SUPER,    P, exec, hyprctl --batch "dispatch togglefloating active; dispatch pin active; ";

      -- #________ WINDOWS ________#
      -- # to switch between windows in a floating workspace
      -- bind = ALT, Tab, cyclenext,               # focuses the next window respecting the layout
      -- bind = ALT, Tab, bringactivetotop,        # bring it to the top
      -- bind = ALT SHIFT, Tab, cyclenext, prev
      -- bind = ALT SHIFT, Tab, bringactivetotop,

      -- ## TODO
      -- bind = SHIFT, F1, exec, ~/.config/hypr/config.d/bind
      -- vim keybind
      --   config_file=~/.config/hypr/confi
      --   keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
      --   keybinds=$(echo "$keybinds" | sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')
      --   rofi -dmenu -p "Keybinds" -theme ~/.config/rofi/themes/catppuccin-mocha.rasi <<< "$keybinds"
    '';
  };
}
