{ pkgs, inputs, ... }:{ 
  programs = {
    home-manager = {
      enable = true;
      # path   = "$HOME/usb_copy/homelab/nixos/user";
    };

    ## run "nix-index" to generate the database in /home/lunics/.cache/nix-index/files
    nix-index = {
      enable = true;
      enableZshIntegration = true;    # mutually exclusive with command-not-found
    };

    command-not-found = {
      enable = false;
      dbPath = "/home/lunics/.cache/nix-index/files";
      # dbPath = "/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite";
    };
  };

  home.packages = with pkgs; [
    comma             # to runs nix software without installing it
  ];
}
