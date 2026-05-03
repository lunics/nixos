{
  networking.extraHosts = ''
    192.168.1.35    elitedesk-800g2
    192.168.1.14    thinkpad-p14s
    192.168.1.18    thinkpad-t14
  '';

  # alternative
  networking.hosts = {
    # "192.168.1.35" = [ "hp-elitedesk-800g2" ];
    # "192.168.1.63" = [ "thinkpad-p14s" ];
  };
}
