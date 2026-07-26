{
  flake.aspects.window_manager.homeManager = { pkgs, ... }:{
    ## dynamc input & bind
    programs = {
      wayprompt = {
        enable   = false;   ## build failed
        # package  = pkgs.wayprompt;
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
  };
}
