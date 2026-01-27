{
  imports = [
    ./startup_apps.nix
    ./udiskie.nix
    # ./nightly_poweroff.nix
    ./wallpaper.nix
    ./podman.nix
    ./ollama.nix
    ./auto-update
    ./auto-upgrade
    # ./usb_sync.nix
    # ./ssh_tpm_agent.nix
  ];
}
