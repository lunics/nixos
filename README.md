## Features

- flake-parts
- flake-aspects
- flake-file
- import-tree
- disko
- dual boot
- lanzaboote
- impermanence
- microvm
- sops-nix
- nixvim
- hosts kept private
- shared options between nixos and home-manager

## Structure

```
nixos
├─ aspects/
├─ modules/
├─ options/
└─ flake.nix
```

## How to integrate nixos as an external flake

This repo exposes `flakeModules.default`. The build entry point is the consumer flake:
`nixos-rebuild switch` and `home-manager switch` run from there, not from here.

<details>
  <summary>flake.nix</summary>

```nix
{
  inputs = {
    nixos = {
      url = "github:lunics/nixos";
      inputs = {
        nixpkgs.follows     = "nixpkgs";
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        # one follows per input shared with nixos
      };
    };

    # nixos stays the source of truth: every input it declares is redeclared here
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.nixos.flakeModules.default
      ((inputs.import-tree.matchNot ".*flake\\.nix") ./.)
    ];
  };
}
```
</details>

<details>
  <summary>host-A/system.nix</summary>

```nix
{ config, ... }:{
  flake.nixosConfigurations = config.flake.lib.make_nixos "x86_64-linux" "host-A";

  flake.aspects = { aspects, ... }:{
    host-A = {
      includes = with aspects; [   # aspects provided by nixos
        options
        boot
        nix
      ];

      nixos = {
        _.hostname  = "host-A";
        _.flake_dir = "/path/to/this/repo";
      };
    };
  };
}
```
</details>

Caveats:

- `self` and `inputs` inside nixos modules resolve against the consumer flake, so its
  input set must cover every `inputs.<name>` used by nixos.
- `flake-file.outputs` comes from `modules/nix/flake-file.nix` and is imported along with
  the tree; override it with `lib.mkForce` to have `write-flake` generate this flake.
- clan state (`inventory.json`, `vars/`) is read relative to the consumer flake root.
