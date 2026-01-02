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
    ./swap.nix
    ./etc
    ./services
    ./location.nix
    ./network
    ./ntp.nix
    # ./users.nix
    ./programs
    ./audio
    ./login_manager.nix
    ./security
    ./fonts.nix
    ./window_manager.nix
    ./virtualisation
    ./gaming
    ./graphic

    # ./auto-upgrade.nix
    ## ./udev
    ## ./server
  ];
}
