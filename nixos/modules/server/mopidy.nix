{ pkgs, ... }:{
  services.mopidy = {
    enable            = false;
    configuration     = "";
    extraConfigFiles  = [];
    dataDir           = "/var/lib/mopidy";
    extensionPackages = [
      # pkgs.mopidy-spotify
      pkgs.mopidy-soundcloud
    ];
  };
}
