{ config, ... }:{
  nix.settings = {
    allowed-users = [ "*" ];          # users allowed to connect to the Nix daemon, trusted users are always allowed to connect, @group to add new group
    trusted-users = [ "root" ]        # users that have additional rights when connecting to the Nix daemon, required for deploy-rs, @group to add new group
      ++config._.nix.trusted-users;

    experimental-features = [ 
      "nix-command" 
      "flakes" 
    ];

    require-sigs = true;              # will only download binaries cryptographically signed from the binary caches
    substituters        = [           # binary cache URLs used to obtain pre-built binaries pkg
      "https://hyprland.cachix.org" 
    ];
    trusted-substituters = [];        # binary cache URLs that non-root users can use
    trusted-public-keys = [           # public keys used to sign binary caches
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
    ];   

    cores    = 0;                     # 0 means that the builder should use all available CPU cores
    max-jobs = "auto";                # maximum number of jobs that Nix will try to build in parallel. will use all available logical cores

    auto-optimise-store   = true;     # detects identical files in the store and replaces them with hard links

    sandbox = true;                   # builds performed in a sandboxed environment, prevents impurities
    # sandbox-paths = [ "/bin/sh=${pkgs.busybox-sandbox-shell.out}/bin/busybox" ];
    # extra-sandbox-paths = [];

    # show-trace = true;
  };
}
