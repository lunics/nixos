{
  flake.aspects.clamav.nixos = {
    services.clamav = {
      daemon.enable       = true;
      fangfrisch.enable   = true;
      fangfrisch.interval = "daily";
      updater.enable      = true;
      updater.interval    = "daily"; # man systemd.time
      updater.frequency   = 12;
      scanner = {
        enable   = true;
        interval = "Sat *-*-* 04:00:00";
      };
    };

    _.persistent-system.dirs = [
      "/var/lib/clamav"    # signature database and the fangfrisch sqlite, redownloaded on every boot otherwise
    ];
  };
}
