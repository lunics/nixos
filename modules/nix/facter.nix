{
  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      options._.facter-report = mkOption {
        type    = types.nullOr types.path;
        default = null;
      };
    };

    facter.nixos = { config, pkgs, ... }:{
      hardware.facter = {
        enable = config.hardware.facter.report != {};   # auto-activation only if a report is set
        reportPath = config._.facter-report;            # JSON file
        # report = {};                                  # JSON inline variant
      };

      environment.systemPackages = with pkgs; [
        nixos-facter
      ];
    };
  };
}
