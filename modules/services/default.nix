{
  imports = [
    ./ssh.nix
    ./tlp.nix
    ./logind.nix
    ./avahi.nix
    ./btrfs_autoscrub.nix
    ./snapraid.nix
    ./snapper.nix
    # ./xserver.nix
  ];

  services = {
    libinput.enable  = true;      # enable touchpad support (enabled default in most desktopManager).
    udisks2.enable   = true;
    udev.enable      = true;
    throttled.enable = false;     # IF intel THEN true ELIF amd THEN false
    printing.enable  = true;
  };
}
