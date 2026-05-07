{ self, ... }:{
  flake.aspects.main.nixos = {
    imports = [ self.modules.generic.options ]
      ++ (with self.modules.nixos; [
        disk
        boot
        nix
        impermanence
        network
        desktop
        audio
        etc
        gaming
        graphic
        hardware
        kernel
        location
        ntp
        users
        programs
        udev
        wsl
      ]);
  };
}
