{ config, inputs, pkgs, ... }:{
  nixpkgs.overlays = [ inputs.nur.overlays.default ];

  programs.firefox.profiles.${config._.user}.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
    # list available plugins: https://nur.nix-community.org/repos/rycee/
    tab-session-manager
    # simple-tab-groups (tab-session-manager alternative)
    vimium
    tabliss
    videospeed
    video-downloadhelper
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
}
