{ config, pkgs, ... }:{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # nixpkgs.overlays =  [ inputs.neovim-nightly-overlay.overlay ];

  # used in bash and zsh modules to add shell completion for packages that provide it.
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [];

  programs.fuse = {
    userAllowOther = true;
    mountMax       = 1000;
  };

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  system.stateVersion = "24.05";
}
