{
  flake.aspects.ssh.nixos = {
    services.openssh = {
      enable   = true;
      ports    = [ 22 ];
      startWhenNeeded = true;
      authorizedKeysFiles = [
        "/run/secrets/ssh-%u"
        "/run/credentials/@system/ssh-%u"   # when in microvm
        # "/run/secrets/user/%u/ssh/*"      ## retry in microvm, seems working in microvm only
      ];
      settings = {
        PermitRootLogin      = "yes";
        PubkeyAuthentication = true;
      };
    };
  };
}
