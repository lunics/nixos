{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    main.includes = with aspects; [
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
        security
        services
        virtualisation
      ]);
  };
}
