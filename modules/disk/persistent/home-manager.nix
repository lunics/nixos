{
  flake.aspects.persistent.nixos = { config, lib, pkgs, ... }:
  let
    _          = config._;
    home       = config.users.users.${_.user}.home;
    generation = "${home}/.local/state/nix/profiles/home-manager";
  in {
    config = lib.mkIf _.persistent-home.ephemeral-btrfs {
      # standalone home-manager keeps its generations in the home, they must outlive the wipe
      preservation.preserveAt.${_.persistent-system.dest}.users.${_.user}.directories = [
        ".local/state/nix"             # profiles, home-manager generations included
        ".local/state/home-manager"    # gcroots of the current generation
      ];

      # relink the wiped home from the last generation before anyone logs in, like home-manager's nixos module
      systemd.services."home-manager-activate-${_.user}" = {
        description = "Reactivate the last home-manager generation of ${_.user}";
        wantedBy    = [ "multi-user.target" ];
        wants       = [ "nix-daemon.socket" ];
        after       = [ "nix-daemon.socket" ];
        before      = [ "systemd-user-sessions.service" ];
        unitConfig  = {
          RequiresMountsFor   = [                           # the preserved bind mounts, not only /home
            "${home}/.local/state/nix" 
            "${home}/.local/state/home-manager" 
          ];    
          ConditionPathExists = "${generation}/activate";   # nothing to relink before the first home-manager switch
        };
        environment.PATH = lib.mkForce "${pkgs.nix}/bin:/run/current-system/sw/bin";
        serviceConfig = {
          Type      = "oneshot";
          User      = _.user;
          ExecStart = "${generation}/activate --driver-version 1";  # 1: reuse the generation, don't create a new one
        };
      };
    };
  };
}
