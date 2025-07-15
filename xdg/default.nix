{
  xdg.enable = true;

  imports = [
    ./autostart.nix
    ./directories.nix
    ./mime_apps.nix
    ./portal.nix
    # ./desktop_entries.nix
  ];
}
