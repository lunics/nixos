{ services = {

  chrony = {
    enable            = true;
    enableNTS         = true;
    enableRTCTrimming = true;

    # KO with NTS enabled
    # failed : Error in the certificate verification. The certificate is NOT trusted
    # servers = [
    #   "0.fr.pool.ntp.org"
    #   "1.fr.pool.ntp.org"
    #   "2.fr.pool.ntp.org"
    #   "3.fr.pool.ntp.org"
    # ];
    # extraConfig = '';
  };

};}
