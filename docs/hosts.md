## flake.nix

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    flake.flakeModules.default = (inputs.import-tree.matchNot ".*flake\\.nix") ./.;
  };
}
```

### Host example

```nix
# hostname-A.nix
{ self, ... }:{
  flake.nixosConfigurations = self.lib.mk_nixos "x86_64-linux" "hostname-A";

  flake.modules.nixos.hostname-A = {
    imports = with self.modules.nixos; [
      base
      disk
    ];
  };
}
```
