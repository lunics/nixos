{ pkgs, ... }:{
  ## nixos non home-manager https://mynixos.com/nixpkgs/options/services.rtorrent
  programs.rtorrent = {
    enable      = true;
    extraConfig = builtins.readFile ./rtorrent.rc;
      # https://github.com/rakshasa/rtorrent/wiki/Config-Guide
    package     = pkgs.rtorrent;
  };

  home.packages = with pkgs; [ rutorrent ];
}
