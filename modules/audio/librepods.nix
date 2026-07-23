{
  flake.aspects.librepods.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      librepods
    ];
  };
}
