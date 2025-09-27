{
  imports = [
    ../options
    ./hardware.nix
    ./disk
    # ./impermanence.nix
    ./boot
    ./nix
    ./configuration.nix
    ./kernel.nix
    ./swap.nix
    ./etc
    ./services
    ./location.nix
    ./network
    ./ntp.nix
    # ./users.nix     KO
    ./audio.nix
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
