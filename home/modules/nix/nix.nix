{
  nix = {
    keepOldNixPath = true;    # keep the previously set values in NIX_PATH
    checkConfig    = true;    # parse nix files before building

    gc = {               # garbage collector
      automatic          = true;
      dates              = "weekly";
      randomizedDelaySec = "0";
      persistent         = true;
      options            = null;
    };

    nixPath = [
      # "$HOME/.nix-defexpr/channels"
      # "darwin-config=$HOME/.config/nixpkgs/darwin-configuration.nix"
    ];
    channels = {};            
      # declarative alternative to Nix channels. Whereas with stock channels, you would register URLs and fetch them into the Nix store with nix-channel(1), this option allows you to register the store path directly. One particularly useful example is registering flake inputs as channels
      # can coexist with stock Nix channels. If the same channel is defined in both, this option takes precedence

    settings = {
      # sandbox = true;
      # show-trace = true;
      # system-features = [ "big-parallel" "kvm" "recursive-nix" ];
    };
    # extraOptions = ''
    #   keep-outputs = true
    #   keep-derivations = true
    # '';
    distributedBuilds = false;
    buildMachines = [];       # machines to be used if distributed builds
    registry = {};
    package = null;
  };
}
