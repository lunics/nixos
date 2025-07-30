{
  # to upgrade cargo\npm\pip global packages, docker containers or different part of the system
  # or get really full system upgrade, use `topgrade` CLI utility manually instead.
  # I recommend running `topgrade` once a week or at least once a month

  # systemctl status nixos-upgrade.timer    # to get the status of the timer run
  # systemctl status nixos-upgrade.service  # The upgrade log can be printed with this command

  system.autoUpgrade = {
    enable    = true;
    operation = "switch";   # If you don't want to apply updates immediately, only after rebooting, use `boot` option in this case
    # flake     = "/etc/nixos";
    flake     = inputs.self.outPath;
    flags     = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    dates     = "weekly";
    # randomizedDelaySec = "45min";
    # channel = "https://nixos.org/channels/nixos-unstable";
  };
}
