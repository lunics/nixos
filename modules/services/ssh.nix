{
  flake.aspects.ssh.nixos = {
    services.openssh = {
      enable   = true;
      ports    = [ 22 ];
      authorizedKeysFiles = ["/run/secrets/user/%u/ssh/*"];  ## retry in microvm, seem working in microvm, ko in host
      settings = {
        PermitRootLogin      = "yes";
        PubkeyAuthentication = true;
      };
    };
  };
}
