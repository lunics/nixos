{ pkgs, ... }:{
  ## dynamc input & bind
  programs = {
    wayprompt = {
      enable   = true;
      package  = pkgs.wayprompt;
      # settings = {
      #   general = {
      #     font-regular = "sans:size=14";
      #     pin-square-amount = 32;
      #   };
      #   colours = {
      #     background = "ffffffaa";
      #   };
      # };
    };
  };
}
