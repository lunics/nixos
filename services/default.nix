{
  imports = [
    ./avahi.nix
    ./ssh.nix
    ./tlp.nix
    # ./xserver.nix
  ];

  services = {
    libinput.enable = true;     # Enable touchpad support (enabled default in most desktopManager).
    udisks2.enable = true;
    udev.enable = true;
    throttled.enable = false;   # IF Intel THEN true ELIF AMD THEN false
    printing.enable = true;
  };
}
