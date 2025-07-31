{
  imports = [
    ../options
    ./hardware.nix
    ./disk
    ./boot.nix
    ./nix
    ./configuration.nix
    ./kernel.nix
    ./swap.nix              # done
    ./etc                   # done
    ./services
    ./location.nix
    ./network
    ./ntp.nix
    ./users.nix
    ./audio.nix             # done
    ./login_manager.nix     # done
    ./security
    ./fonts.nix
    ./window_manager.nix    # done
    ./virtualisation        # done
    ./gaming                # done
    ./graphic               ##
    ## ./udev
    ## ./server
  ];
}
