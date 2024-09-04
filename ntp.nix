{ services = {

  chrony = {
    enable            = true;
    enableNTS         = true;
    enableRTCTrimming = true;
    servers = [
      "0.fr.pool.ntp.org"
      "1.fr.pool.ntp.org"
      "2.fr.pool.ntp.org"
      "3.fr.pool.ntp.org"
    ];
    # extraConfig = '';
  };

};}
