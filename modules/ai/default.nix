{ config, pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    # chatgpt           # desktop app, not available on x86_64-linux
    # shell-gpt         # KO build 17/10/25
    # open-interpreter  # KO build pygame
    claude-code
    opencode
    # gpt-cli
  ];

  imports = [ 
    # ./crush.nix
    ./chatgpt.nix
  ];
}
