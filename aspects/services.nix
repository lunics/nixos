{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    services.includes = with aspects; [
      alarm-clock
      auto-upgrade
      fwupd
      logind
      no-wakeup
      podman
      # ssh                 # listed directly in the aspect lists
      startup_apps
      thermald
      tlp
      udiskie
      upower
    ];
  };
}
