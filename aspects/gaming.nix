{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    gaming.includes = with aspects; [
      gamemode
      gamescope
      lutris
      mangohud
      nixgl
      obs
      steam
    ];
  };
}
