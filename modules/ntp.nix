{ services = {

  chrony = {
    enable            = true;
    enableNTS         = true;
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
    # extraConfig = '';
  };

};}
