{ config, pkgs, ... }:{ 
  # home.packages = with pkgs; [ 
  #   # open-interpreter  # KO build pygame
  # ];

  imports = [ 
    # ./crush.nix
    ./chatgpt.nix
    ./fabric-ai.nix
    ./opencode.nix
    ./mcp.nix
    ./claude.nix
  ];
}
