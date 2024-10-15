{ config, pkgs, ... }:{

users.users.lunics = {
  isNormalUser   = true;
  isSystemUser   = false;
  description    = "Lunics";
  uid            = 1000;
  extraGroups    = [ "wheel" "networkmanager" ];
  # mkpasswd -m sha-512
  hashedPassword = "$6$***REMOVED***.$hRDFVzLIat/XPZK8DeG1DXpRkfiVfZbrk/VYkWQjAmmDC8Q6R8Gb5LOy.x.S.RQGrXIgNF.w2tmCqW4crcnrP1";
  # password     = TODO SOPS;
  shell          = pkgs.zsh;
  packages       = with pkgs; [
    home-manager
    neovim
    # neovim-nightly
    git
    lazygit
  ];
  openssh = {
    authorizedKeys.keys = [       # /etc/ssh/authorized_keys.d/lunics
      # bootstrap
      "ssh-ed25519 ***REMOVED*** lunics@laptop-t14"
      # ~/.ssh/yubikey.pub
      "sk-ssh-ed25519@openssh.com ***REMOVED***+d335wMFPigNWxLOBg/2XAAAAC3NzaDpob21lbGFi ssh@***REMOVED***"
      # elitedesk-800g2-nixos.pub
      "ssh-ed25519 ***REMOVED*** lunics@laptop-t14"
    ];
  };
};

  # Change runtime directory size. automatically systemd managed per-user directory more secure than /tmp
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
