{ pkgs, inputs, ... }:{ 
  programs.home-manager = {
    enable = true;
    # path   = "$HOME/usb_copy/homelab/nixos/user";
  };

  ## run "nix-index" to generate the database in /home/lunics/.cache/nix-index/files
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.command-not-found = {
    enable = true;
    dbPath = "/home/lunics/.cache/nix-index/files";
    # dbPath = "/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite";
  };

  home.packages = with pkgs; [
    comma             # to runs nix software without installing it
  ];
}
