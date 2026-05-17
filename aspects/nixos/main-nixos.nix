{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    main-nixos.includes = with aspects; [
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
