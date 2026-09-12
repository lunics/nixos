{
  flake.aspects.hyprlock.homeManager = { config, pkgs, ... }:{
    _.lock-screen = "hyprlock";
    _.lock-cmd    = "hyprlock";

    programs.hyprlock = {
      enable            = true;
      package           = pkgs.hyprlock;
      sourceFirst       = true; # enable putting source entries at the top of the configuration
      importantPrefixes = [ "$" "bezier" "monitor" "size" ];
      settings          = {};
      extraConfig       = "";
    };
  };
}
