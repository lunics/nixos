{ config, pkgs, ... }: {
  systemd.user = {
    services."flake-update" = {
      Unit.Description = "update all flake inputs";
      Service = {
        Type      = "oneshot";
        ExecStart = [ 
          "${pkgs.flake-update}/bin/flake-update"
          "${pkgs.commit-git-flake}/bin/commit-git-flake"
        ];
      };
    };
  };
}
