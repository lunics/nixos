{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    services.includes = with aspects; [
      alarm-clock
      auto-upgrade
      fwupd
      logind
      no-wakeup
      podman
      ssh                   # nixos service + home client
      startup_apps
      thermald
      tlp
      udiskie
      upower
    ];
  };
}
