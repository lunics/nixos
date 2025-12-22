{ config, inputs, lib, pkgs, ... }:{ 
  home = {
    packages = with pkgs; [
      inputs.yt-x.packages."${stdenv.hostPlatform.system}".default
      yt-dlp
      kitty       # dependency for icat image preview
    ];

    activation.link_to_share = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln ${config._.share}/yt-x/recent.json ${config._.dot_config}/yt-x/recent.json &> /dev/null || true
    '';
  };

  # get logs: yt-x &> yt-x.log

  xdg.configFile."yt-x/yt-x.conf".text = ''
    AUTO_LOADED_EXTENSIONS: 
    PRETTY_PRINT: true                # whether to show colors when printing ouput
    EDITOR: nvim
    PREFERRED_SELECTOR: fzf           # fzf, rofi
    VIDEO_QUALITY: 1080               # the quality of the video when streaming with a player other than mpv
    ENABLE_PREVIEW: true
    IMAGE_RENDERER: icat              # what to use for rendering images in the terminal [chafa/icat]
    DISOWN_STREAMING_PROCESS: true    # whether to run mpv as a background process and prevent it from closing even if you terminate the program or terminal session
    UPDATE_RECENT: true               # whether to update the recent list kept locally [true/false]
    SEARCH_HISTORY: true              # whether to update the recent list kept locally [true/false]
    NO_OF_RECENT: 30                  # the number of recent videos to keep
    PLAYER: mpv                       # the player to use for streaming [mpv/vlc]
    PREFERRED_BROWSER: firefox:${config._.share}/browser/zen/lunics   # browser's profile use to extract cookies from, used to by yt-dlp to access content that would require login
    NO_OF_SEARCH_RESULTS: 30          # the number of results to get from yt-dlp
    NOTIFICATION_DURATION: 5          # the duration notifications stay on the screen
    DOWNLOAD_DIRECTORY: /home/lunics/videos/yt-x
    UPDATE_CHECK: false
    # CHAFA_ARGS: "--format kitty --passthrough tmux"
  '';
}
