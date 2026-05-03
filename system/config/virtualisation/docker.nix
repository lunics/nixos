{ config, lib, ... }:{
  config = lib.mkIf config._.docker {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true; 
      };
    };

    users.extraGroups.docker.members = [ "lunics" ];
  };
}
