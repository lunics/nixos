{
  services = {
    udiskie = {
      enable    = true;
      automount = true;
      notify    = true;
      tray      = "auto";  # auto, always, never
    };
  };
}
