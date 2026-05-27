## Features

- ✅ flake-parts
- ✅ flake-aspects
- ✅ flake-file
- ✅ import-tree
- ✅ disko
- ✅ dual boot
- ✅ lanzaboote
- ✅ impermanence
- ✅ microvm
- ✅ sops-nix
- ✅ nixvim
- ✅ hosts kept private
- ✅ shared options between nixos and home-manager

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

    flake-aspects.url = "github:vic/flake-aspects";

    import-tree.url = "github:vic/import-tree";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
  flake.nixosConfigurations = self.lib.make_nixos "x86_64-linux" "host-A";

  flake.modules.nixos.host-A = {
    imports = with self.modules.nixos; [
      all-system
    ];
  };
}
```
</details>
