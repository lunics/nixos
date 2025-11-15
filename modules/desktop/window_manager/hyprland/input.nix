{ config, ... }:{
  wayland.windowManager.hyprland.extraConfig = ''
    input {
      kb_layout     = ${config._.hyprland.kb_layout}
      kb_variant    =                 # altgr-intl = us layout with european accent
      kb_model      =                 # pc105
      kb_options    = caps:escape     # turn caps as an escape key
      kb_rules      =
    
      repeat_rate   = 70              # repeat rate for held keys
      repeat_delay  = 230             # delay before the spam
    
      numlock_by_default = false
    
      # /usr/share/wayland-sessions/hyprland.desktop:env NO_WRT_MOUSEHRDW.. un truc comme ca: ne fix pas hide mouse error streamlink
      follow_mouse   = 1              # window focus will follow mouse and vice versa
      force_no_accel = true           # bypasses pointer settings to get as raw of a signal as possible
      sensitivity    = 0              # -1.0 - 1.0, 0 means no modification. KO doesn't change anything
    
      touchpad {
        disable_while_typing    = true
        natural_scroll          = false
        clickfinger_behavior    = false
        middle_button_emulation = false
        tap-to-click            = true
        drag_lock               = false
      }
    }
    
    # Example per-device config
    # https://wiki.hyprland.org/Configuring/Advanced-config/#per-device-input-configs
    #device:name {
    #
    #}
  '';
}
