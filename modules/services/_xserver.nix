{
  flake.aspects.services.nixos = {
    services.xserver = {
      enable                      = true;
      displayManager.gdm.enable   = true;
      desktopManager.gnome.enable = true;
      xkb = { 
        layout = "fr"; 
        variant = ""; 
      };
    };
  };
}
