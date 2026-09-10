{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    all-nixos.includes = with aspects; [
      options
      disk
      boot
      nix
      hardware
      facter
      kernel
      etc
      network
      desktop_nixos
      desktop-nixos
      audio
      steam
      graphic
      location
      ntp
      programs
      udev
      wsl
      security
      services
      ssh
      virtualisation
      secrets
    ];
  };
}
