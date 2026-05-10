## Features

- ✅ flake-parts
- ✅ flake-aspects
- ✅ flake-file
- ✅ import-tree
- ✅ disko
- ✅ dual boot
- ✅ lanzaboote
- ✅ microvm
- ✅ impermanence
- ✅ hosts kept private

## Structure

```
nixos
├─ aspects/
├─ hosts/       # external repo
├─ modules/
├─ options/
└─ flake.nix
```

## How to setup hosts from an external repo

<details>
  <summary>flake.nix</summary>

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
</details>

<details>
  <summary>host-A.nix</summary>

```nix
{ self, ... }:{
  flake.nixosConfigurations = self.lib.mk_nixos "x86_64-linux" "host-A";

  flake.modules.nixos.host-A = {
    imports = with self.modules.nixos; [
      base
      disk
    ];
  };
}
```
</details>
