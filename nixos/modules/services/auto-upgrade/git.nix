{ config, ... }:{
  # required by system.autoUpgrade if the config is based on a flake (git) owned by a user
  programs.git = {    
    enable = true;
    config = {
      safe.directory = [
        "${config._.flake_dir}"
      ];
    };
  };
}
