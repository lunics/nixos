{ config, inputs, pkgs, ... }:{
  nixpkgs.overlays = [ inputs.nur.overlays.default ];

  programs.firefox.profiles.${config._.user}.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
    # list available plugins: https://nur.nix-community.org/repos/rycee/
    tab-session-manager
    # simple-tab-groups (tab-session-manager alternative)
    vimium
    tabliss
    videospeed
    leechblock-ng
    consent-o-matic
    skip-redirect
    adnauseam
    # ublock-origin
    auto-tab-discard
    behave
    darkreader
    gesturefy
    gopass-bridge
    hover-zoom-plus
    enhancer-for-youtube
    multi-account-containers
    open-url-in-container
    istilldontcareaboutcookies
    keepa                         # amazon price tracker
    pipewire-screenaudio          # connect webcall to pipewire
    refined-github
    return-youtube-dislikes
    scroll_anywhere
    simple-translate
    skip-redirect
    # temporary-containers-plus
    # deepl
    # tab-stash
    # musescore-downloader        # download sheet music from musescore.com

    # zen-internet
  ];

  # profiles.PROFILE_NAME.extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
  # todo line 518 /h/l/d/r/nixos/official/nur-expressions/pkgs/firefox-addons/addons.json

    # localcdn useless: Third parties are already partitioned if you use Total Cookie Protection (dFPI)
    # # simple-tab-groups   # session manager alternative
    # ipvfoo
    
    # i open tabs next to current
      # firefox 'ext+container:name=MyContainer&url=https://mozilla.org'
      # firefox 'ext+container:name=MyContainer&color=orange&icon=fruit&url=https://mozilla.org&pinned=true'
    
    # ghosttext
    # # immersive-translate
    # # gitako-github-file-tree
    
    # # momentumdash
    
    # h264ify
    # jump-cutter
    
    # browserpass
    # passff
    # keeper KO not defined
    
    # lovely-forks
    # refined-github
    
    # omnivore
    
    # tokyo-night-v2
    # theme-nord-polar-night
    # gruvbox-dark-theme
    # gnome-shell-integration
    
    # ipfs-companion
    # simplelogin     # self-hostable email alias protection
    # pushbullet
    # joplin-web-clipper
    # authenticator
    # wallabagger
    # Bukubrow
    # single-file
    # hoppscotch        request API builder
  # ];
}
