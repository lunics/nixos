{ pkgs, ... }:{
  home.packages = with pkgs; [
    lutris
    # ankama-launcher available from steam or from ankama-launcher.nix ?

    steam-tui
    steamcmd

    protonup-qt       # GUI for managing versions of proton, dxvk, vkd3d
    playonlinux       # GUI for managing Windows programs under linux
    piper             # 10 MB - app to configure gaming mice
    gamemode
    mangohud          # give statistic performance, fps, power usage
    vkbasalt          # post processor layer to improve the game's graphic
    dualsensectl      # to manage PS5 controller

    # wine
    wine64
    winetricks
  ];


  # Dofus
    # dl ankama-launcher for official website
    # nix-shell -p appimage-run
    # appimage-run ./Ankama\ Launcher-Setup-x86_64.AppImage

    # imports = [
    #   ./ankama-launcher.nix
    # ];
}
