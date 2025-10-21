{
  imports = [
    ../options
    ./hardware.nix
    ./disk
    ./boot
    ./nix
    ./system.nix
    ./kernel.nix
    ./swap.nix
    ./etc
    ./services
    ./location.nix
    ./network
    ./ntp.nix
    ./users.nix
    ./programs
    ./audio.nix
    # ./login_manager.nix
    ./security
    ./fonts.nix
    ./window_manager.nix
    ./virtualisation
    ./gaming
    ./graphic

    # ./impermanence.nix
    # ./auto-upgrade.nix
    ## ./udev
    ## ./server
  ];
}
