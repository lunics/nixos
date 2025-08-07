{
  # systemctl status nixos-upgrade.timer
  # systemctl status nixos-upgrade.service
  system.autoUpgrade = {
    enable             = true;
    operation          = "switch";   # switch, boot; use "boot" to apply updates only after rebooting
    flake              = inputs.self.outPath;    # ex: "/etc/nixos";
    channel            = null;       # run nix-channel --list to see the default value
    flags = [ 
      "--update-input" 
        "unstable disko"             # add all inputs
      "--commit-lock-file" 
    ];
    dates              = "weekly";   # 04:40, daily, weekly...
    fixedRandomDelay   = false;
    randomizedDelaySec = "0";     # ex: 45min; randomized delay before each automatic upgrade
    persistent         = false;    # useful to catch up on missed runs of the service when the system was powered down
    upgrade            = true;
    allowReboot        = false;
    rebootWindow = {       # time window during which reboots are allowed after an upgrade
      lower = "01:00";     # lower limit of the reboot window
      upper = "05:00";     # upper limit of the reboot window
  };

  
  # topgrade
  # ${XDG_CONFIG_HOME:-~/.config}/topgrade/topgrade.toml
  # to upgrade cargo\npm\pip global packages, docker containers or different part of the system
  # or get really full system upgrade, use `topgrade` CLI utility manually instead.
  # I recommend running `topgrade` once a week or at least once a month
  topgrade = {
    enable = true;
    # package = pkgs.topgrade;
    settings = {
      misc = {
        assume_yes = true;
        disable = [
          "flutter"
          "node"
        ];
        set_title = false;
        cleanup = true;
      };
      commands = {
        "Run garbage collection on Nix store" = "nix-collect-garbage";
      };
    };
  };
}
