{ 
  imports = [
    # ./gtk.nix
    ./launcher
    # ./lock_screen.nix
    ./notifier.nix
    # ./gtk.nix
    # ./qt.nix
    ./status_bar
    ./window_manager
    # ./wallpaper.nix   KO CMake Error
  ]; 
}
