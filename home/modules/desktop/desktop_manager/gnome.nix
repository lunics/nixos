{ pkgs, ... }:{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  programs.dconf.enable = true;     # needed for running extensions outside of gnome

  home.packages = with pkgs; [ 
    gnome.adwaita-icon-theme        # many apps rely heavily on an icon theme
    gnome.gnome-settings-daemon     # ensure gnome-settings-daemon udev rules are enabled
    gnomeExtensions.airpod-battery-monitor
    gnomeExtensions.appindicator
  ];

# automatic login
#   # IF
#   services.xserver.displayManager.autoLogin.enable = true;
#   services.xserver.displayManager.autoLogin.user = "account";
#   # THEN
#   systemd.services."getty@tty1".enable = false;
#   systemd.services."autovt@tty1".enable = false;

#   # exclude useless built-in gnome apps
#   environment.gnome.excludePackages = (with pkgs; [
#     atomix              # puzzle game
#     cheese              # webcam tool
#     epiphany            # web browser
#     evince              # document viewer
#     geary               # email reader
#     gedit               # text editor
#     gnome-characters
#     gnome-music
#     gnome-photos
#     gnome-terminal
#     gnome-tour
#     hitori              # sudoku game
#     iagno               # go game
#     tali                # poker game
#     totem               # video player
#   ]);

#   home-manager.users.myuser = {
#     dconf = {
#       enable = true;
#       settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";    # dark mode
#       settings."org/gnome/shell" = {
#         disable-user-extensions = false;
#         enabled-extensions = with pkgs.gnomeExtensions; [
#           blur-my-shell.extensionUuid
#           gsconnect.extensionUuid
#         ];
#       };
#     };
#   };
}
