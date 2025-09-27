{ config, pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    # chatgpt             # desktop app, not available on x86_64-linux
    shell-gpt
    open-interpreter
  ];

  home.shellAliases = {
    ai = "sgpt --shell --model gpt-4o";
  };

  home.sessionVariables = {
    OPENAI_API_KEY = "${config._.openai_api_key}";
  };
}
