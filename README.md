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
  <summary>flake.nix — minimal</summary>

```nix
{
  inputs.nixos.url = "github:lunics/nixos";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.nixos.flakeModules.default
      ((inputs.import-tree.matchNot ".*flake\\.nix") ./.)
    ];
  };
}
```

Only the entry point is provided here. nixos modules resolve `inputs.<name>` against this
flake, so declaring the inputs they use is left to the consumer.
</details>

<details>
  <summary>flake.nix — inputs followed from nixos</summary>

Declaring them as `follows` keeps nixos as the single source of truth: its own `flake.lock`
drives every version and no url is ever duplicated.

```nix
{
  inputs = {
    nixos.url = "github:lunics/nixos";

    nixpkgs.follows     = "nixos/nixpkgs";
    flake-parts.follows = "nixos/flake-parts";
    import-tree.follows = "nixos/import-tree";
    # one line per input used by nixos
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.nixos.flakeModules.default
      ((inputs.import-tree.matchNot ".*flake\\.nix") ./.)
    ];
  };
}
```

Bumping a version means committing it in nixos, then `nix flake update nixos` here.
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
- the consumer flake is written by hand: `write-flake` would regenerate it with every url
  duplicated, so override `flake-file.outputs` with `lib.mkForce` only if that is wanted.
- clan state (`inventory.json`, `vars/`) is read relative to the consumer flake root.
