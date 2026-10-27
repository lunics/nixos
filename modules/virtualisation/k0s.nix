{ inputs, ... }:{
  flake-file.inputs.k0s = {
    url = "github:nix-community/k0s-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.k0s.nixos = { config, lib, pkgs, ... }:{
    imports = [ inputs.k0s.nixosModules.default ];

    config = lib.mkIf config._.k0s {
      environment.systemPackages = with pkgs; [
        inputs.k0s.packages.${pkgs.stdenv.hostPlatform.system}.k0s
        k0sctl      # bootstrapping and management tool for k0s clusters
      ];

      services.k0s = {
        enable      = false;
        packages    = inputs.k0s.packages.${pkgs.stdenv.hostPlatform.system}.k0s;
        role        = "single";    # controller, controller+worker, worker, single
        dataDir     = "${config._.kubernetes.btrfs-subvol}/k0s";
        tokenFile   = "${config._.kubernetes.btrfs-subvol}/k0s-token";   # outside the data dir, a k0s reset must not take it
        clusterName = "k0s";
        spec        = {};
        configText  = "";      # the configuration file in yaml format
        extraArgs   = "";      # extra arguments to pass to systemd ExecStart
      };

      # nothing to declare for preservation, the data dir sits on the kubernetes btrfs subvolume
    };
  };
}
