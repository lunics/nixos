{ config, pkgs, ... }:{ services = {

  xserver = {
    enable = true;
    libinput.enable = true;     # Enable touchpad support (enabled default in most desktopManager).
    displayManager.gdm.enable   = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout  = "fr";
      variant = "";};};

  openssh = {
    enable   = true;
    ports    = [ 22 ];
    settings = {
      PermitRootLogin      = "yes";
      PubkeyAuthentication = true;};};

  printing.enable = true;
};}
