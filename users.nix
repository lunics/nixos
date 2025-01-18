{ config, pkgs, ... }:{

  users = {
    users.lunics = {
      isNormalUser   = true;
      isSystemUser   = false;
      description    = "Lunics";
      uid            = 1001;
      extraGroups    = [ "wheel" "networkmanager" ];
      # mkpasswd -m sha-512
      hashedPassword = "$6$***REMOVED***.$hRDFVzLIat/XPZK8DeG1DXpRkfiVfZbrk/VYkWQjAmmDC8Q6R8Gb5LOy.x.S.RQGrXIgNF.w2tmCqW4crcnrP1";
      # password     = TODO SOPS;
      shell          = pkgs.zsh;
      packages       = with pkgs; [
        home-manager
        # neovim
        # neovim-nightly
        git
        lazygit
      ];
      openssh = {
        authorizedKeys.keys = [       # /etc/ssh/authorized_keys.d/lunics
          # homelab
          "ssh-ed25519 ***REMOVED*** lunics@laptop-t14"
          # ~/.ssh/yubikey.pub
          "sk-ssh-ed25519@openssh.com ***REMOVED***+d335wMFPigNWxLOBg/2XAAAAC3NzaDpob21lbGFi ssh@***REMOVED***"
          # elitedesk-800g2-nixos.pub
          # old: "ssh-ed25519 ***REMOVED*** lunics@laptop-t14"
          "ssh-ed25519 ***REMOVED*** lunics@elitedesk-800g2"
        ];
      };
    };

    # groups = {
    #   fuse = {    # A DELETE si anakama-launcher ne l'utilise pas
    #     members = [ "lunics" ];
    #   };
    # };
  };

  # Change runtime directory size. automatically systemd managed per-user directory more secure than /tmp
  # limit $XDG_RUNTIME_DIR=/run/user/1000 to 8 GB max; check with: df -h /run/user/1000
  # tmpfs is limited to half of your ram by default, but each tmpfs mounting can be customized
  services.logind.extraConfig = "RuntimeDirectorySize=4G";    # 4G or 10% work
}
