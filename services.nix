{ config, pkgs, ... }:{ services = {

  libinput.enable = true;     # Enable touchpad support (enabled default in most desktopManager).

  udisks2.enable = true;

  # xserver = {
  #   enable = true;
  #   displayManager.gdm.enable   = true;
  #   desktopManager.gnome.enable = true;
  #   xkb = {
  #     layout  = "fr";
  #     variant = "";   };};

  openssh = {
    enable   = true;
    ports    = [ 22 ];
    settings = {
      PermitRootLogin      = "yes";
      PubkeyAuthentication = true;  }; };


  throttled.enable = false;   # IF Intel THEN true ELIF AMD THEN false

  avahi = {
    enable   = false;
    nssmdns4 = true;
    publish  = {
      enable    = false;
      addresses = true;   }; };

  printing.enable = true;

  tlp = {
    enable   = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 41;
      STOP_CHARGE_THRESH_BAT0  = 91;
      START_CHARGE_THRESH_BAT1 = 41;
      STOP_CHARGE_THRESH_BAT1  = 91;
    };
  };
};}
