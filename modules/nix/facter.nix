{
  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      options._.facter-report = mkOption {
        type    = types.nullOr types.path;
        default = null;
      };
    };

    facter.nixos = { config, lib, pkgs, ... }:{
      hardware.facter = {
        enable = config.hardware.facter.report != {};   # auto-activation only if a report is set

        # left null, clan keeps its own machines/<name>/facter.json
        reportPath = lib.mkIf (config._.facter-report != null) (lib.mkForce config._.facter-report);
        # report = {};                                  # JSON inline variant
      };

      environment.systemPackages = with pkgs; [
        nixos-facter
      ];
    };
  };
}
