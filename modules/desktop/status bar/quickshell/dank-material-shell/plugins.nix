{ inputs, ... }:{
  flake-file.inputs.dms-plugin-registry = {
    url = "github:AvengeMedia/dms-plugin-registry";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.dank-material-shell.homeManager = { config, pkgs, ... }:{
    imports = [ inputs.dms-plugin-registry.nixosModules.default ];

    programs.dank-material-shell = {
      managePluginSettings = true;
    
      plugins = {
        dankBatteryAlerts.enable = false;
        dockerManager.enable     = false;

        mediaPlayer = {
          enable = true;
          settings = {
            preferredSource = "spotify";
          };
        };
      };
    };
  };
}
