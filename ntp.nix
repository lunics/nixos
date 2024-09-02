{
  services = {
    # can't be run at the same time than chrony or ntp
    systemd-timesyncd.enable = false;

    chrony = {
      enable    = true;
      enableNTS = true;
      # servers   = [ "ntp-example.com" ];
    };
  };
}
