{
  flake.aspects.pass_manager = {
    homeManager = { config, lib, pkgs, ... }:{
      config = lib.mkIf (config._.keyring == "gnome-keyring") {
        _.persistent-home.dirs = [
          { directory = ".local/share/keyrings"; mode = "0700"; }
        ];

        services.gnome-keyring = {
          enable     = true;
          package    = pkgs.gnome-keyring;
          components = [];              # "pkcs11", "secrets", "ssh"
        };

        home.packages = [ pkgs.gcr_3 ];   # Provides org.gnome.keyring.SystemPrompter
      };
    };

    # unlocks the keyring at login, the homeManager side only runs the daemon
    nixos = { config, lib, ... }:{
      security.pam.services.login.enableGnomeKeyring =
        lib.mkIf (config._.keyring == "gnome-keyring") true;
    };
  };
}
