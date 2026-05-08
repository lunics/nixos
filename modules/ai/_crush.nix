{ config, inputs, ... }:{
  imports = [ 
    inputs.nur.modules.homeManager.default              # OK
    # inputs.nur.repos.charmbracelet.modules.crush-hm   # KO repos missing
    # inputs.nur.repos.charmbracelet.homeModules.crush  # //
    # inputs.nur.repos.charmbracelet.modules.crush      # //
    # inputs.nur.homeModules.crush                      # KO homeModules missing
  ];
  
  programs.crush = {
    enable = false;
    settings = {
      providers = {
        openai = {
          id       = "openai";
          name     = "OpenAI";
          base_url = "https://api.openai.com/v1";
          type     = "openai";
          api_key  = config._.openai_api_key;
          models = [
            {
              id   = "gpt-4";
              name = "GPT-4";
            }
          ];
        };
      };
      lsp = {
        go  = { command = "gopls"; enabled = true; };
        nix = { command = "nil";   enabled = true; };
      };
      options = {
        context_paths = [ "/etc/nixos/configuration.nix" ];
        tui           = { compact_mode = true; };
        debug         = false;
      };
    };
  };
}
