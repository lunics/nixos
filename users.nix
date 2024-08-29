{ config, pkgs, ... }:{
  users.users.lunics = {
    isNormalUser = true;
    description = "Lunics";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
}
