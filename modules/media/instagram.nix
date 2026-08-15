{
  flake.aspects.media.homeManager = { config, lib, pkgs, ... }:{ 
    config = lib.mkMerge [{
      home.packages = with pkgs; [
        instaloader       # dl insta videos/pictures with metadatas
      ];

    }(lib.mkIf (config._.instaloader-login != null) {
      xdg.configFile."instaloader/session-user".source = config._.instaloader-login;
    })];
  };
}
