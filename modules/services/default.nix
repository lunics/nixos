{
  imports = [
    ./startup_apps.nix
    ./udiskie.nix
    # ./nightly_poweroff.nix
    ./wallpaper
    ./pomodoro
    ./alarm_clock
    ./podman.nix
    ./ollama.nix
    ./auto-upgrade.nix
    # ./usb_sync.nix
    # ./ssh_tpm_agent.nix
  ];

  systemd.user.startServices = "sd-switch";   # suggest, sd-switch
}
