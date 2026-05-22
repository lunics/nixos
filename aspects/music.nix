{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    music.includes = with aspects; [
      home-studio
      rmpc
      mpd
      # musescore
    ];
  };
}
