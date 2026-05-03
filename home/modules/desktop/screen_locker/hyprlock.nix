{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.screen_locker == "hyprlock") {
    programs.hyprlock = {
      enable            = true;
      package           = pkgs.hyprlock;
      sourceFirst       = true; # enable putting source entries at the top of the configuration
      importantPrefixes = [ "$" "bezier" "monitor" "size" ];
      settings          = {};
      extraConfig       = "";
    };

    xdg.configFile."hypr/hyprlock.conf".text = builtins.readFile ./hyprlock.conf;
  };
}
