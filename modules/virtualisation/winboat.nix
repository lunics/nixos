{
  flake.aspects = { aspects, ... }:{
    winboat = {
      includes = with aspects; [
        docker
      ];
      homeManager = { config, lib, pkgs, ... }:{
        _.persistent-home.dirs = [ ".winboat" ];    # config and windows vm storage

        home.packages = with pkgs; [
          winboat
          # (unstable.winboat.override {nodejs_24 = pkgs.nodejs_24;})
          freerdp
        ];
        nixpkgs.config.permittedInsecurePackages = [
          "electron-40.10.5"
        ];
      };
    };
  };
}
