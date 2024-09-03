{ config, pkgs, ... }:{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-b6890844-2d38-4f35-807f-2ad2922ae9a5".device = "/dev/disk/by-uuid/b6890844-2d38-4f35-807f-2ad2922ae9a5";

  # used in bash and zsh modules to add shell completion for packages that provide it.
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  # nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.firefox.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  fonts.fontconfig.enable = true;

  system.stateVersion = "24.05";
}
