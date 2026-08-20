{
  flake.aspects.gaming.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      ryubing           # nintendo switch emulator

      # steam-tui         ##  Permission denied ## TODO supprimer de system et le remettre ici, need /tmp noexec to be built

      protonup-ng       # Proton GE
      protonup-qt       # GUI for managing versions of proton, dxvk, vkd3d
      playonlinux       # GUI for managing Windows programs under linux
      vkbasalt          # post processor layer to improve the game's graphic

      piper             # 10 MB - app to configure gaming mice
      dualsensectl      # to manage PS5 controller

      # wine            # required by lutris
      # wine64            # conflict with wine
      # winetricks

      # faugus-launcher   # lightweight app for running Windows games using umu-launcher
      # umu-launcher
    ];
  };
}
