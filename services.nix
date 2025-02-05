{
  services = {
    udiskie = {
      enable    = true;
      automount = true;
      notify    = true;
      tray      = "auto";  # auto, always, never
    };

    # .podman   allows user to define containers that will run as systemd services
  };
}
