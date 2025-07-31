{ pkgs, ... }:{ 
  programs = {
    home-manager = {
      enable = true;
      # path   = "$HOME/usb_copy/homelab/nixos/home";
    };

    ## run "nix-index" to generate the database in /home/lunics/.cache/nix-index/files
    nix-index = {       # send message if command fail: The program '#' is currently not installed: nix-shell -p  --run '# ...'
      enable = false;
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
    distrobox
    deploy-rs
  ];
}
