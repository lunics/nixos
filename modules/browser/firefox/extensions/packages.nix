{ inputs, ... }:{
  flake-file.inputs.nur = {     # nixos community repo: firefox-addons, crush
    url = "github:nix-community/NUR";
    inputs.nixpkgs.follows = "nixpkgs"; 
  };

  flake.overlays.nur = inputs.nur.overlays.default;    # applied by the builders, home-manager reuses the system pkgs

  flake.aspects.browser.homeManager = { config, pkgs, ... }:{
    _.allow-unfree = with pkgs.nur.repos.rycee.firefox-addons; [ 
      enhancer-for-youtube 
      keepa
      scroll_anywhere
    ];

    programs.firefox.profiles.${config._.user}.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      # list available plugins: https://nur.nix-community.org/repos/rycee/
      tab-session-manager
      # simple-tab-groups (tab-session-manager alternative)
      vimium
      tablissng
      videospeed
      # video-downloadhelper
      leechblock-ng
      consent-o-matic
      skip-redirect
      adnauseam
      auto-tab-discard
      behave
      darkreader
      gesturefy
      # gopass-bridge
      ## hover-zoom-plus    reinstall once the repo has updated the new name
      multi-account-containers
      open-url-in-container
      istilldontcareaboutcookies
      refined-github
      return-youtube-dislikes
      simple-translate
      skip-redirect
      # temporary-containers-plus
      # deepl
      # tab-stash
      # musescore-downloader        # download sheet music from musescore.com

      # zen-internet
    ];
  };
}
