{
  imports = [
    ../options
    ./hardware.nix
    ./disk
    ./boot
    ./nix
    ./impermanence.nix
    ./system.nix
    ./kernel.nix
    ./etc
    ./services
    ./location.nix
    ./network
    ./ntp.nix
    # ./users.nix
    ./programs
    ./audio
    ./desktop
    ./security
    ./fonts.nix
    ./virtualisation
    ./gaming
    ./graphic
    ./wsl.nix

    # ./auto-upgrade.nix
    ## ./udev
    ## ./server
  ];
}
