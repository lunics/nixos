{
  flake.aspects.sshd.nixos = {
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
        PermitRootLogin              = "no";
        PubkeyAuthentication         = true;
        AuthenticationMethods        = "publickey";
        PasswordAuthentication       = false;
        KbdInteractiveAuthentication = false;
        PermitEmptyPasswords         = false;
        MaxAuthTries                 = 3;
        LoginGraceTime               = 30;
        ClientAliveInterval          = 300;
        ClientAliveCountMax          = 2;
        AllowAgentForwarding         = false;
        LogLevel                     = "VERBOSE";             # logs key fingerprints for auditing
      };
    };
  };
}
