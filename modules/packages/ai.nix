{ config, pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    open-interpreter
    shell-gpt
  ];

  home.shellAliases = {
    ai = "sgpt --shell --model gpt-4o";
  };

  home.sessionVariables = {
    OPENAI_API_KEY = "${config._.openai_api_key}";
  };
}
