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
        X11Forwarding                = false;
        GatewayPorts                 = "no";
        StrictModes                  = true;
        UseDns                       = false;
        LogLevel                     = "VERBOSE";

        # nixos defaults, Mozilla modern recommendations
        KexAlgorithms                = [
          "mlkem768x25519-sha256"
          "sntrup761x25519-sha512"
          "sntrup761x25519-sha512@openssh.com"
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group-exchange-sha256"
        ];
        Ciphers                      = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
          "aes128-gcm@openssh.com"
          "aes256-ctr"
          "aes192-ctr"
          "aes128-ctr"
        ];
        Macs                         = [
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-256-etm@openssh.com"
          "umac-128-etm@openssh.com"
        ];
      };
    };
  };
}
