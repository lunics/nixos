{ config, pkgs, ... }:{ users.users = {

lunics = {
  isNormalUser   = true;
  isSystemUser   = false;
  description    = "Lunics";
  uid            = 1000;
  extraGroups    = [ "wheel" "networkmanager" ];
  # mkpasswd -m sha-512
  hashedPassword = "$6$***REMOVED***$WUOZvh/EQjZ9rqhLszgkhwpLmgoSAbTDGEX3sAxoJyiMdsD31OgT2RidXCznIEUzsw/459BoZWpKiHxqC8Nct/";
  # password     = TODO SOPS;
  shell        = pkgs.bash;
  packages       = with pkgs; [
    neovim
    git
    lazygit
  ];
  openssh = {
    authorizedKeys.keys = [
      # homelab
      "ssh-ed25519 ***REMOVED*** lunics@laptop-t14"
      # ~/.ssh/yubikey.pub
      "sk-ssh-ed25519@openssh.com ***REMOVED***+d335wMFPigNWxLOBg/2XAAAAC3NzaDpob21lbGFi ssh@***REMOVED***"
    ];
  };
};

};}
