{ pkgs, ... }:{
  imports = [
    ../../modules/default.nix
  ];

  _hostName = "hp-elitedesk-800g2";

  _k3s = true;

  _user = {
    # name = 
    uid            = 1001;
    extraGroups    = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$***REMOVED***.$hRDFVzLIat/XPZK8DeG1DXpRkfiVfZbrk/VYkWQjAmmDC8Q6R8Gb5LOy.x.S.RQGrXIgNF.w2tmCqW4crcnrP1";
    shell          = pkgs.bash;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1SM37A6vUk3Fxz2Uus5t5nZxkgbsFaVV8i9zXI4zSm ssh@***REMOVED***" # ~/.ssh/servers.pub
      "sk-ssh-ed25519@openssh.com ***REMOVED***xvpLdAR8YlXZEK/rAkFMAAAAC3NzaDp5dWJpa2V5 ssh@***REMOVED***"   # ~/.ssh/yubikey.pub
    ];
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
