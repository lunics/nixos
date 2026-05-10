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
      desktop
      audio
      gaming
      graphic
      location
      ntp
      users
      programs
      udev
      wsl
      security
      services
      virtualisation
    ];
  };
}
