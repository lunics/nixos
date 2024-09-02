{ config, pkgs, ... }:{ users.users = {

lunics = {
  isNormalUser = true;
  description  = "Lunics";
  extraGroups  = [ "networkmanager" "wheel" ];
  shell        = pkgs.zsh;
  packages     = with pkgs; [
    #  thunderbird
  ];
};
};}
