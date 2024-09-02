{ config, pkgs, ... }:{ users.users = {

lunics = {
  isNormalUser = true;
  isSystemUser = false;
  description  = "Lunics";
  uid          = 1000;
  extraGroups  = [ "wheel" "networkmanager" ];
  # hashedPassword =
  # password     = TODO SOPS;
  shell        = pkgs.zsh;
  packages     = with pkgs; [
    #  thunderbird
  ];
  openssh = {
    authorizedKeys.keys = [
      "ssh-ed25519 ***REMOVED*** lunics@laptop-t14"
    ];
  };
};

};}
