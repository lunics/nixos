{
  flake.aspects.services.nixos = {
    services = {
      libinput.enable  = true;   # touchpad support (enabled by default in most desktopManagers)
      udisks2.enable   = true;
      udev.enable      = true;
      throttled.enable = false;  # intel throttling fix: true for intel, false for amd
      printing.enable  = true;
    };

    _.persistent-system.dirs = [
      "/var/lib/cups"    # cups server root, holds the printers added at runtime
    ];
  };
}
