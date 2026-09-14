{
  flake.aspects.window_manager.homeManager = { config, lib, ... }:
  let
    keyboard = config._.hyprland.kb-device;
  in {
    # per-device layout: the internal keyboard keeps the global kb_layout
    wayland.windowManager.hyprland.extraConfig = lib.mkIf (keyboard.name != "") ''
      hl.device({
        name       = "${keyboard.name}",
        kb_layout  = "${keyboard.kb_layout}",
        kb_variant = "${keyboard.kb_variant}",   -- not optional: enables the AltGr dead keys the accent macros rely on
      })
    '';
  };
}
