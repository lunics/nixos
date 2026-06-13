{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    all-nixos.includes = with aspects; [
      options
      disk
      boot
      nix
      impermanence
      hardware
      kernel
      etc
      network
      desktop_nixos
      desktop-nixos
      audio
      gaming-nixos
      steam
      graphic
      location
      ntp
      programs
      udev
      wsl
      security
      services
      virtualisation
      secrets
    ];
  };
}
