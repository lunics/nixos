### flake.nix

```nix
{
  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    ...
    system.url = "github:lunics/nix_system";
  };

  outputs = inputs@{ self, unstable, system, ... }:{
    nixosConfigurations.myhostname = unstable.lib.nixosSystem {
      system      = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        system.nixosModules.system
        ./hosts/myhostname/system/default.nix
      ];
    };
  };
}
```

### ./hosts/myhostname/system/default.nix

```nix
{
  _ = rec {
    hostName          = "myhostname";
    boot_loader       = "systemd-boot";
    login_manager     = true;
    window_manager    = true;
    audio             = true;
    graphic           = true;
    gaming            = false;
    k3s               = true;
    microvm.enable    = true;
    disk.luks         = true;
    zramSwap.enable   = true;

    impermanence = true;
    persistent.dirs = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      # "/snapshots"
    ];
  };
}
```
