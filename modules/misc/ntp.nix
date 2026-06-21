{
  flake.aspects.ntp.nixos = { lib, ... }:{
    services.chrony = {
      enable            = true;
      enableNTS         = lib.mkDefault true;
      enableRTCTrimming = true;
      servers = [
        "0.nixos.pool.ntp.org"
        "1.nixos.pool.ntp.org"
        "2.nixos.pool.ntp.org"
        "3.nixos.pool.ntp.org"

        # KO with NTS enabled
        # failed : Error in the certificate verification. The certificate is NOT trusted
        # "0.fr.pool.ntp.org"
        # "1.fr.pool.ntp.org"
        # "2.fr.pool.ntp.org"
        # "3.fr.pool.ntp.org"
      ];
      # allow chrony to step the clock immediately on large offsets,
      # instead of slowly slewing (which can take a long time for a 2h gap)
      extraConfig = lib.mkDefault ''
        makestep 1.0 3
      '';
    };
  };
}
