{
  flake.aspects.hyprlock = {
    # without its pam service hyprlock falls back to /etc/pam.d/other, which denies every unlock
    nixos.security.pam.services.hyprlock = {};

    homeManager = { config, pkgs, ... }:{
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
  };
}
