{ pkgs, ... }:{
  home.packages = with pkgs; [
    lutris
    # ankama-launcher available from steam or from ankama-launcher.nix ?

    # steam-tui       ## TODO supprimer de system et le remettre ici, need /tmp noexec to be built
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
}
