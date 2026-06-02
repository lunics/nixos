{ self, ... }:{
  flake.aspects.network.nixos = { config, lib, ... }:{
    networking = {
      hostName = config._.hostname;

      useDHCP = lib.mkDefault true;

      # interfaces.wlp3s0.useDHCP    = lib.mkDefault true;
    };

    # network diagnostic tool that combines ping and traceroute into one program
    programs.mtr.enable = true;
  };
}
