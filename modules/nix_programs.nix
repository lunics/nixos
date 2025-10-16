{ config, pkgs, ... }:{ 
  programs = {
    home-manager = {
      enable = true;
      # path   = "$HOME/nixos/home";
    };

    ## run "nix-index" to generate the database in /home/$USER/.cache/nix-index/files, takes btw 5-20 min
    nix-index = {       
      enable = true;
      enableZshIntegration = false;    
        # mutually exclusive with command-not-found
        # send message if command fail: The program '#' is currently not installed: nix-shell -p  --run '# ...'
    };

    command-not-found = {
      enable = false;
      dbPath = "${config._.dot_cache}/nix-index/files";
      # dbPath = "/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite";
    };
  };

  home.packages = with pkgs; [
    deploy-rs
    # nix-init          # generate Nix packages from URLs
    # comma             # to runs nix software without installing it
  ];
}
