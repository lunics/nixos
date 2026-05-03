{ pkgs, config, ... }:{ 
  home.packages = with pkgs; [
    mpd
    mpd-notification
    # mpd-mpris
    # mpd-discord-rpc
  ];

  services.mpd = {
    enable  = true;
    musicDirectory = "${config._.home}/music";     # where mpd reads music from
    extraConfig = ''
      auto_update "yes"         # auto update db
      restore_paused "yes"      # startup behavior

      audio_output {
        type "pipewire"
        name "pipewire"
        # device "iec958:CARD=Intel,DEV=0"
        # mixer_control "PCM"
      } 
    '';
    network = {
      startWhenNeeded = true;
      listenAddress = "127.0.0.1";
      port = 6600;
    };
    ## KO is not of type 'absolute path'
      # dataDir = "$XDG_DATA_HOME/mpd";
      # dbFile  = "$XDG_DATA_HOME/mpd/tag_cache";             # MPD's database
      # playlistDirectory = "$XDG_DATA_HOME/mpd/playlists";   # where mpd stores playlists
    # extraArgs = [];
  };
}
