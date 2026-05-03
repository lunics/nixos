{ config, pkgs, ... }: {
  systemd.services."home-manager-upgrade" = {
    description = "upgrade home manager";
    serviceConfig = {
      Type      = "oneshot";
      User      = config._.user;
      Environment = "PATH=${pkgs.nix}/bin:/run/current-system/sw/bin";
      ExecStart = [ 
        "${pkgs.home-manager}/bin/home-manager switch --flake ${config._.flake_dir}#${config._.user}"
      ];
    };
  };
}
