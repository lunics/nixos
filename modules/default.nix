{
  imports = [
    ./hardware.nix
    ./disk
    ./boot.nix
    ./nix
    ./configuration.nix
    ./kernel.nix
    ./swap.nix
    ./etc
    ./services
    ./location.nix
    ./network
    ./ntp.nix
    ./users.nix
    ./audio.nix
    ./login_manager.nix
    ./security
    ./fonts.nix
    ./window_manager.nix
    ./virtualisation
    ./gaming
    ./graphic
    ./dirs.nix
    ## ./udev
    ## ./server
  ];
}
