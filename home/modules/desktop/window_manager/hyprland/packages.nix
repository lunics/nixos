{ pkgs, ... }:{
  home.packages = with pkgs; [
    waypaper
    # hyprpaper  # KO
    # hyprlock   # choose with swaylock
    hyprpicker
    wl-clipboard
    # wl-clipboard-rs   # KO to install
                        # collision between `/nix/store/y89kpm6rk0kib5rg8mkwcvhq5h6v2jyi-wl-clipboard-2.2.1/bin/wl-copy' and `/nix/store/jwafgnncls2lyx0jpxy5pfij7bm3ixh2-wl-clipboard-rs-0.9.1/bin/wl-copy'
    # clipboard-jh      # needs wl-clipboard, KO screen flickering even with: exec-once = cb
    brightnessctl
    grimblast           # grim + slurp to take screenshot
  ];
}
