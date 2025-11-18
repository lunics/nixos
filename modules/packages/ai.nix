{ config, pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    # chatgpt           # desktop app, not available on x86_64-linux
    # shell-gpt         # KO build 17/10/25
    open-interpreter
  ];

  home.shellAliases = {
    ai = "sgpt --shell --model gpt-4o";
  };

  home.sessionVariables = {
    OPENAI_API_KEY = "${config._.openai_api_key}";
  };
}
