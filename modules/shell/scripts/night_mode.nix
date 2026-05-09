{
  flake.aspects.scripts.homeManager = { pkgs, ... }:{
    home.packages = [
      (pkgs.writeShellApplication {
        name = "night_mode";

        text = ''
          save_env

          pkill firefox
          pkill taskwarrior-tui
          # pkill mullvad-gui

          hyprctl dispatch dpms off

          hyprlock --config "$HOME"/.config/hypr/hyprlock_nightly.conf
        '';
      })
    ];
  };
}
