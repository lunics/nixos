{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    shell.includes = with aspects; [
      functions
      nushell
      scripts
      zsh
      aliases
      bash
      exports
      history
      prompt
    ];
  };
}
