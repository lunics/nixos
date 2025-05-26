{
  # doesn't recreate dir or file if it does exist already
  systemd.tmpfiles.rules = [
    "d /home/lunics/usb_copy    0750 lunics users -"
    "d /home/lunics/screenshots 0750 lunics users -"
    "d /home/lunics/downloads   0750 lunics users -"
    "d /home/lunics/torrents    0750 lunics users -"
    "d /home/lunics/repos       0750 lunics users -"
  ];
}

