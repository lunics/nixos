{
  flake.aspects.auto-upgrade.nixos = { config, pkgs, ... }:{
    systemd.services."flake-update" = {
      description = "update all flake inputs";
      serviceConfig = {
        Type        = "oneshot";
        User        = config._.user;
        Environment = "PATH=${pkgs.git}/bin:/run/current-system/sw/bin";
        ExecStart   = [
          "${pkgs.flake-update}/bin/flake-update"
          "${pkgs.commit-git-flake}/bin/commit-git-flake"
        ];
      };
    };
  };
}
