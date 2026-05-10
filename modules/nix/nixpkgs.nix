{
  flake.aspects.nix-nixos.nixos = { config, lib, ... }: {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
      hostPlatform  = lib.mkDefault "x86_64-linux";
      buildPlatform = config.nixpkgs.hostPlatform;
      # localSystem   = (import "${nixos}/../lib").lib.systems.examples.aarch64-multiplatform;
      # crossSystem = null;
      # system = {
      #   _type = "literalMD";
      #   text = "Traditionally `builtins.currentSystem`, but unset when invoking NixOS through `lib.nixosSystem`.\n";
      # }
      # pkgs = import "${nixos}/.." {
      #   inherit (cfg) config overlays localSystem crossSystem;
      # }
      # overlays = [
      #   (self: super: {
      #     openssh = super.openssh.override {
      #       hpnSupport = true;
      #       kerberos = self.libkrb5;
      #     };
      #   })
      # ]
      # flake = {
      #   setFlakeRegistry = config.nixpkgs.flake.source != null;
      #   setNixPath = config.nixpkgs.flake.source != null;
      #   source = if (using nixpkgsFlake.lib.nixosSystem) then self.outPath else null;
      # };
    };
  };
}
