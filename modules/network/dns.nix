{
  networking.extraHosts = ''
    192.168.1.35    hp-elitedesk-800g2
    192.168.1.63    thinkpad-p14s
  '';

  # alternative
  # networking.hosts = {
  #   "192.168.1.35" = [ "hp-elitedesk-800g2" ];
  #   "192.168.1.63" = [ "thinkpad-p14s" ];
  # };
}
