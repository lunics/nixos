{
  flake.modules.nixos.network = { config, lib, ... }:{
    networking = {
      hostName = config._.hostName;

      useDHCP = lib.mkDefault true;

      # interfaces.wlp3s0.useDHCP    = lib.mkDefault true;
    };

    # network diagnostic tool that combines ping and traceroute into one program
    programs.mtr.enable = true;
  };
}
