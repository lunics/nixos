{ pkgs, ... }:{
  home = {
    packages = with pkgs; [ gopass ];

    file.".config/gopass/config".source = ./gopass_config;
  };
}
