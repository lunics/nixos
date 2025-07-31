{ pkgs, ... }:{
  imports = [
    ../../modules/default.nix
  ];

  _ = {
  #   # hostName        = "thinkpad-p14s";
  #   audio           = true;
  #   login_manager   = true;
  #   window_manager  = true;
  #   virtualisation  = true;
  #   k3s             = false;
  #   gaming          = true;
  #   zramSwap.enable = true;
  #   crypttab.text   = "luks-2590eb50-1395-4c41-955b-976a599e2a3f UUID=f03d5303-948c-4842-934c-727cbc5039be /home/lunics/usb_luks.key noauto";
    user = {
  #     uid            = 1001;
  #     extraGroups    = [ "wheel" "networkmanager" ];
  #     hashedPassword = "$6$***REMOVED***.$hRDFVzLIat/XPZK8DeG1DXpRkfiVfZbrk/VYkWQjAmmDC8Q6R8Gb5LOy.x.S.RQGrXIgNF.w2tmCqW4crcnrP1";
      shell          = pkgs.zsh;
      packages       = with pkgs; [
        home-manager
        # neovim
        # neovim-nightly
        git
        lazygit
      ];
    };
  };

  security.sudo-rs = {
    wheelNeedsPassword = false;
    extraRules = [
      {
        users    = [ "lunics" ];
        host     = "ALL";
        runAs    = "ALL:ALL";
        commands = [ "/run/current-system/sw/bin/poweroff" ];
      }
    ];
  };
}
