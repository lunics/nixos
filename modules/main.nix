{ self, ... }:{
  flake.modules.nixos.main = {
    imports = [ self.modules.generic.options ]
      ++ (with self.modules.nixos; [
        disk
        boot
        nix
        impermanence
      ]);
  };
}
