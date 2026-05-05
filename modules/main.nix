{
  flake.modules.nixos.main = {
    imports = with self.modules.generic; [ options ];

    imports = with self.modules.nixos; [
      disk
      boot
      nix
      impermanence
    ];
  };
}
