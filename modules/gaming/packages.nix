{
  flake.aspects.gaming.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      appimage-run      # to run dofus app image

      ryubing           # nintendo switch emulator

      # steam-tui         ##  Permission denied ## TODO supprimer de system et le remettre ici, need /tmp noexec to be built

      protonup-ng       # Proton GE
      # protonup-qt     # GUI for managing versions of proton, dxvk, vkd3d
      playonlinux       # GUI for managing Windows programs under linux
      piper             # 10 MB - app to configure gaming mice
      gamemode
      mangohud          # give statistic performance, fps, power usage
      vkbasalt          # post processor layer to improve the game's graphic
      dualsensectl      # to manage PS5 controller
      # umu-launcher

      # wine            # required by lutris
      wine64            # conflict with wine
      winetricks

      # ankama-launcher
    ];
  };
}
