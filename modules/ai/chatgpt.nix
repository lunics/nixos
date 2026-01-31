{ config, pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    # chatgpt           # desktop app, not available on x86_64-linux
    # shell-gpt         # KO build 17/10/25
    # gpt-cli
  ];

  home.shellAliases = {
    ai = "sgpt --shell --model gpt-4o";
  };

  home.sessionVariables = {
    OPENAI_API_KEY = config._.openai_api_key;
  };

  programs.codex = {
    enable   = false;
    package  = pkgs.codex;
    settings = {};
    skills   = {};
    custom-instructions = "";
  };
}
