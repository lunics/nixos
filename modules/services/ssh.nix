{
  flake.aspects.ssh.nixos = {
    services.openssh = {
      enable   = true;
      ports    = [ 22 ];
      authorizedKeysFiles = ["/run/secrets/user/%u/ssh/*"];
      settings = {
        PermitRootLogin      = "yes";
        PubkeyAuthentication = true;
      };
    };
  };
}
