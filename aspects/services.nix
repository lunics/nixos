{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    services.includes = with aspects; [
      alarm-clock
      auto-upgrade
      pomodoro
      fwupd
      logind
      no-wakeup
      podman
      ssh
      startup_apps
      tlp
      udiskie
      upower
    ];
  };
}
