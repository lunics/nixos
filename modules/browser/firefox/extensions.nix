{ pkgs, inputs, ... }:{
  programs.firefox.profiles.PROFILE_NAME.extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
  # todo line 518 /h/l/d/r/nixos/official/nur-expressions/pkgs/firefox-addons/addons.json
                                            # TODO with pkgs.nur.repos.rycee.firefox-addons; [

    # i ublock-origin
    # i behave
    # localcdn useless: Third parties are already partitioned if you use Total Cookie Protection (dFPI)
    # i skip-redirect
    # i consent-o-matic
    # # simple-tab-groups   # session manager alternative
    # i istilldontcareaboutcookies
    # ipvfoo
    
    # i multi-account-containers
    # i temporary-containers
    # i tab-session-manager
    # i auto-tab-discard
    # i open tabs next to current
    # i open-url-in-container
      # firefox 'ext+container:name=MyContainer&url=https://mozilla.org'
      # firefox 'ext+container:name=MyContainer&color=orange&icon=fruit&url=https://mozilla.org&pinned=true'
    
    # i vimium
    # gesturefy
    # ghosttext
    # i hover-zoom-plus
    # i simple-translate
    # # immersive-translate
    # # gitako-github-file-tree
    
    # i tabliss
    # # momentumdash
    
    # h264ify
    # i videospeed
    # # jump-cutter
    # return-youtube-dislikes
    # # musescore-downloader
    
    # i pipewire-screenaudio    # to connect webcall to pipewire
    
    # browserpass
    # passff
    # keeper KO not defined
    
    # i lovely-forks
    # refined-github
    
    # # keepa   amazon price traker
    # # darkreader
    # # omnivore
    
    # # tokyo-night-v2
    # # theme-nord-polar-night
    # # gruvbox-dark-theme
    # # gnome-shell-integration
    
    # # ipfs-companion
    # # simplelogin     # self-hostable email alias protection
    # # pushbullet
    # # joplin-web-clipper
    # # authenticator
    # # wallabagger
    # # Bukubrow
    # # single-file
    # # hoppscotch        request API builder
  ];
}
