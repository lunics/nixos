{ config, ... }:
let
  _hypr = config._.hyprland;
in {
  wayland.windowManager.hyprland.extraConfig = ''
    binds {
      allow_workspace_cycles = true
    }
    
    $SUPER  = SUPER         # SHIFT CAPS CTRL/CONTROL ALT MOD2 MOD3 SUPER/WIN/LOGO/MOD4 MOD5
    $SSHIFT = SUPER SHIFT
    
    bind  = ${_hypr.toggle_bt},  exec, toggle_bt_device 90:5F:7A:BC:93:87
    bind  = ${_hypr.toggle_bar}, exec, hyprpanel toggleWindow bar-0
    #bindr = $SUPER,     SUPER_L, exec, ulauncher-toggle
    bind  = $SUPER,     F, togglefloating,
    bind  = $SUPER,     L, exec, swaylock
    bind  = $SUPER,     Q, killactive,
    ## remove once task 69 done: bind  = $SUPER,     R, exec, pkill wofi || (export PATH="$HOME/.local/share/devbox/global/default/.devbox/nix/profile/default/bin:$PATH" && echo $PATH > $HOME/test.log && wofi)
    bind  = $SUPER,     R, exec, pkill wofi || wofi
    bind  = $SUPER,     ${_hypr.suspend}, exec, _suspend                       # >& $HOME/_suspend.log
    bind  = $SSHIFT,    ${_hypr.suspend}, exec, systemctl suspend & swaylock
    bind  = $SUPER,     M, exec, hyprctl dispatch dpms toggle eDP-1

    # bind = , F11, exec, sudo -A systemctl suspend && swaylock
    bind  = $SUPER,     T, exec, alacritty
    bind  = $SSHIFT,    T, exec, alacritty --title terminal_floats
    bind  = $SUPER,     V, exec, toggle_vpn
    # bind  = $SUPER,   H, FOCUS LEFT WINDOW
    # bind  = $SUPER,   L, FOCUS RIGHT WINDOW
    
    
    bind  = $SUPER,     P, exec, toggle_pomodoro
    # bind = $SUPER,    P,      pseudo,            # dwindle  KO
    # bind = $SUPER,    P,      pin, active        # pin the current window across all workspaces
    
    bind = $SSHIFT,     BACKSPACE, movetoworkspace, special       # move active window to the special workspace
    bind = $SUPER,      BACKSPACE, togglespecialworkspace         # toggle pin the special workspace on top of the current workspace
    
    bind = $SUPER, Z, togglesplit,
    # bind = $SUPER,       P, exec, hyprctl --batch "dispatch togglefloating active; dispatch pin active; ";
    
    # change window focus
    bind = $SUPER, left,  movefocus, l
    bind = $SUPER, right, movefocus, r
    bind = $SUPER, up,    movefocus, u
    bind = $SUPER, down,  movefocus, d
    
    # screenshot
    bind = $SUPER SHIFT, S, exec, grimblast --notify copysave area ${config._.share}/screenshots/$(date +"%d-%m-%Y%H-%M-%S").png
    
    #________ WINDOWS ________#
    # to switch between windows in a floating workspace
    bind = ALT, Tab, cyclenext,               # focuses the next window respecting the layout
    bind = ALT, Tab, bringactivetotop,        # bring it to the top
    bind = ALT SHIFT, Tab, cyclenext, prev
    bind = ALT SHIFT, Tab, bringactivetotop,
    
    #________ WORKSPACES ________#
    
    bind = , ${_hypr.prev_workspace}, workspace, previous
    bind = SUPER, space, workspace, previous
    bindr = SUPER, SUPER_L, workspace, previous
    
    # Switch to workspace [0-9]
    bind = $SUPER, ${_hypr.workspace."1"}, workspace, 1
    bind = $SUPER, ${_hypr.workspace."2"}, workspace, 2
    bind = $SUPER, ${_hypr.workspace."3"}, workspace, 3
    bind = $SUPER, ${_hypr.workspace."4"}, workspace, 4
    bind = $SUPER, ${_hypr.workspace."5"}, workspace, 5
    bind = $SUPER, ${_hypr.workspace."6"}, workspace, 6
    bind = $SUPER, ${_hypr.workspace."7"}, workspace, 7
    bind = $SUPER, ${_hypr.workspace."8"}, workspace, 8
    bind = $SUPER, ${_hypr.workspace."9"}, workspace, 9
    bind = $SUPER, agrave,     workspace, 10
    
    # Move active window to a workspace [0-9]
    bind = $SSHIFT, ${_hypr.workspace."1"}, movetoworkspace, 1
    bind = $SSHIFT, ${_hypr.workspace."2"}, movetoworkspace, 2
    bind = $SSHIFT, ${_hypr.workspace."3"}, movetoworkspace, 3
    bind = $SSHIFT, ${_hypr.workspace."4"}, movetoworkspace, 4
    bind = $SSHIFT, ${_hypr.workspace."5"}, movetoworkspace, 5
    bind = $SSHIFT, ${_hypr.workspace."6"}, movetoworkspace, 6
    bind = $SSHIFT, ${_hypr.workspace."7"}, movetoworkspace, 7
    bind = $SSHIFT, ${_hypr.workspace."8"}, movetoworkspace, 8
    bind = $SSHIFT, ${_hypr.workspace."9"}, movetoworkspace, 9
    bind = $SSHIFT, agrave,     movetoworkspace, 10
    
    # Scroll through existing workspaces with SUPER + scroll
    bind = $SUPER, mouse_down, workspace, e+1
    bind = $SUPER, mouse_up  , workspace, e-1
    
    bindm = $SUPER, mouse:272, movewindow           # super + left click  = move window
    bindm = $SUPER, mouse:273, resizewindow         # super + right click = resize window

    # volume control
    bindl = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    binde = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+   # -l 2 = 200% max
    bind  = ,XF86AudioMute       , exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind  = ,XF86AudioMicMute    , exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    
    # brightness
    bind = ,XF86MonBrightnessUp,   exec, brightnessctl set +5%
    bind = ,XF86MonBrightnessDown, exec, brightnessctl set 5%-
    
    ## TODO
    #bind = SHIFT, F1, exec, ~/.config/hypr/config.d/bind
    # vim keybind
    #   config_file=~/.config/hypr/confi
    #   keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
    #   keybinds=$(echo "$keybinds" | sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')
    #   rofi -dmenu -p "Keybinds" -theme ~/.config/rofi/themes/catppuccin-mocha.rasi <<< "$keybinds"
  '';
}
