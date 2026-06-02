{
  flake.aspects.auto-upgrade.nixos = { config, lib, pkgs, ... }:{
    system.autoUpgrade = {              # Enable the nixos-update script and service
      enable               = true;      # run nixos-rebuild switch --upgrade once a day
      dates                = "Fri *-*-* 20:00:00";  # run every friday at 20h
      upgrade              = false;     # disable adding the --upgrade parameter when channel is not set, such as when upgrading to the latest version of a flake honouring its lockfile
      operation            = "switch";  # switch, boot. Whether to run nixos-rebuild switch --upgrade or run nixos-rebuild boot --upgrade
      persistent           = true;
      randomizedDelaySec   = "0";       # delay before each automatic upgrade
      fixedRandomDelay     = false;     # reduces the jitter between automatic upgrades
      runGarbageCollection = false;     # automatically run nix-gc.service after a successful system upgrade
      allowReboot          = false;
      rebootWindow = {                  # only if allowReboot is enabled
        lower = "01:00";
        upper = "05:00";
      };
      flake                = "${config._.flake_dir}#${config._.hostname}";      # Flake URI, Disables the option system.autoUpgrade.channel
      channel              = null;      # URI of the NixOS channel
      flags                = [
        # "--recreate-lock-file"
        # "--commit-lock-file"
      ];        # additional flags passed to nixos-rebuild
    };

    systemd.services.nixos-upgrade = {
      requires = [ "flake-update.service" ];
      wants    = [ "home-manager-upgrade.service" ];
      after    = [ "flake-update.service" ];
      before   = [ "home-manager-upgrade.service" ];
    };

    # lib.mkAfter ensures your script runs AFTER the upgrade command
    # systemd.services.nixos-upgrade.serviceConfig = {
    #   ExecStartPre = [
    #     "${pkgs.systemd}/bin/systemctl --user --machine=${config._.user}@.host start flake-update.service"
    #   ];
    #   ExecStart = lib.mkAfter [
    #     "${pkgs.systemd}/bin/systemctl --user --machine=${config._.user}@.host start home-manager-auto-upgrade.service"
    #   ];
    # };
  };
}
