{
  nix = {
    enable = true;
    # package = pkgs.nix;

    channel.enable = true;        # whether the nix-channel command and state files are made available on the machine
      # files initialized when enabled
      #   /nix/var/nix/profiles/per-user/root/channels
      #   /root/.nix-channels
      #   $HOME/.nix-defexpr/channels (on login)

    checkAllErrors = true;        # checks the nix.conf parsing for any kind of error
    checkConfig    = true;        # checks that Nix can parse the generated nix.conf

    distributedBuilds = false;    
    buildMachines     = [];       # lists the machines to be used if distributed builds are enabled
                                  # will perform derivations on those machines via SSH by copying the inputs to the Nix store on the remote machine, starting the build, then copying the output back to the local Nix store

    daemonIOSchedClass    = "best-effort";    # best-effort, idle;  Nix daemon process I/O scheduling class
    daemonIOSchedPriority = 4;                # Nix daemon process I/O scheduling priority
    daemonCPUSchedPolicy  = "other";          # other, batch, idle; Nix daemon process CPU scheduling policy
  };

  imports = [
    # ./buildMachines.nix
    ./gc.nix
    ./optimise.nix
    # ./registry.nix    ## TODO
    ./settings.nix
    ./sshServe.nix
  ];
}
