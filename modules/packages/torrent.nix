{ config, lib, pkgs, ... }:{
  ## nixos non home-manager https://mynixos.com/nixpkgs/options/services.rtorrent
  programs.rtorrent = {
    enable      = true;
    extraConfig = builtins.readFile ./rtorrent.rc;
      # https://github.com/rakshasa/rtorrent/wiki/Config-Guide
    package     = pkgs.rtorrent;
  };

  home.activation.torrents-dir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ${config._.downloads}/torrents
  '';

  xdg.dataFile."applications/rtorrent-magnet.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=rtorrent-magnet
    Exec=open-magnet %U
    MimeType=x-scheme-handler/magnet;
    NoDisplay=true
  '';

  xdg.mimeApps.defaultApplications."x-scheme-handler/magnet" =
    [ "rtorrent-magnet.desktop" ];

  home.packages = [
    pkgs.rutorrent       # web interface using rtorrent

    (pkgs.writeScriptBin "open-magnet" ''
      #!${pkgs.stdenv.shell}
      watch_folder=~/torrents/rtorrent/watch
      cd $watch_folder
      [[ "$1" =~ xt=urn:btih:([^&/]+) ]] || exit;
      echo "d10:magnet-uri''${#1}:''${1}e" > "meta-''${BASH_REMATCH[1]}.torrent"
      ${pkgs.noti}/bin/noti -t "magnetizer" -m "added magnet link to $watch_folder"
    '')
  ];
}
