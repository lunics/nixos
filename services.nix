{ config, pkgs, ... }:{ services = {

  libinput.enable = true;     # Enable touchpad support (enabled default in most desktopManager).

  xserver = {
    enable = true;
    displayManager.gdm.enable   = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout  = "fr";
      variant = "";   };};

  openssh = {
    enable   = true;
    ports    = [ 22 ];
    settings = {
      PermitRootLogin      = "yes";
      PubkeyAuthentication = true;  };};

  avahi = {
    enable  = true;
    nssmdns = true;
    # package = pkgs.avahi;
    publish = {
      enable    = true;
      addresses = true; };};

  printing.enable = true;

};}
