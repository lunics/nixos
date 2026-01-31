{ config, pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    # open-interpreter  # KO build pygame
    claude-code
  ];

  imports = [ 
    # ./crush.nix
    ./chatgpt.nix
    ./fabric-ai.nix
    ./opencode.nix
    ./mcp.nix
  ];
}
