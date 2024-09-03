{
  services = {
    chrony = {
      enable            = true;
      enableNTS         = true;
      enableRTCTrimming = true;
      # extraConfig = '';
      # servers   = [ "ntp-example.com" ];
    };
  };
}
