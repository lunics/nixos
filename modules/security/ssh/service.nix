{
  flake.aspects.ssh.nixos = {
    services.openssh = {
      enable   = true;
      ports    = [ 22 ];
      authorizedKeysFiles = [
        "/run/secrets/ssh-%u"
        # "/run/secrets/user/%u/ssh/*"      ## retry in microvm, seems working in microvm only
      ];
      settings = {
        PermitRootLogin      = "yes";
        PubkeyAuthentication = true;
      };
    };
  };
}
