{ config, pkgs, ... }:{

  # Enable the nixos-update script and service
  system.autoUpgrade = {
    enable = true;
    flags = "--update";
  };

  # Define a systemd service for upgrading the system
  systemd.services.auto-upgrade = {
    description = "Automatic System Upgrade";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --upgrade";
    };
  };

  # Define a systemd timer to schedule the upgrade
  systemd.timers.auto-upgrade = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
