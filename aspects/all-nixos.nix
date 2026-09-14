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
      desktop
      audio
      steam
      graphic
      location
      ntp
      programs
      wsl
      security
      services
      ssh
      virtualisation
      secrets
    ];
  };
}
