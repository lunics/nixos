{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    localsend
    android-file-transfer
    # magic-wormhole
    magic-wormhole-rs
    warp                  # wormhole gnome client
  ];
}
