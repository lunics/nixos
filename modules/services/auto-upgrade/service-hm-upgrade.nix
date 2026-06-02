{
  flake.aspects.auto-upgrade.nixos = { config, pkgs, ... }: let
    _ = config._;
  in {
    systemd.services."home-manager-upgrade" = {
      description = "upgrade home manager";
      serviceConfig = {
        Type        = "oneshot";
        User        = _.user;
        Environment = "PATH=${pkgs.nix}/bin:/run/current-system/sw/bin";
        ExecStart   = [ "${pkgs.home-manager}/bin/home-manager switch --flake ${_.flake_dir}#${_.user}" ];
      };
    };
  };
}
