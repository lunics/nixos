{
  flake.aspects.services.nixos = {
    services.openssh = {
      enable   = true;
      ports    = [ 22 ];
      settings = {
        PermitRootLogin      = "yes";
        PubkeyAuthentication = true;
      };
    };
  };
}
