{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    mpd
    mpd-notification
    # mpd-mpris
    # mpd-discord-rpc
  ];

  services.mpd = {
    enable  = true;
    network = {
      startWhenNeeded = true;
      listenAddress = "127.0.0.1";
      port = 6600;
    };
    musicDirectory = "$HOME/music";
    ## KO is not of type 'absolute path'
      # dataDir = "$XDG_DATA_HOME/mpd";
      # dbFile  = "$XDG_DATA_HOME/mpd/tag_cache";   # MPD's database
      # playlistDirectory = "$XDG_DATA_HOME/mpd/playlists";
    # extraConfig "";
    # extraArgs = [];
  };
}
