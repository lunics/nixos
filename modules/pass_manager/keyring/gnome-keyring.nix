{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.keyring == "gnome-keyring") {
    services.gnome-keyring = {
      enable     = true;
      package    = pkgs.gnome-keyring;
      components = [];              # "pkcs11", "secrets", "ssh"
    };

    home.packages = [ pkgs.gcr ];   # Provides org.gnome.keyring.SystemPrompter
  };
}
