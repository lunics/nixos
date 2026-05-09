{
  flake.aspects.editor.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      anytype         # p2p note-taking tool
      anytype-heart   # shared library for Anytype clients
    ];
  };
}
