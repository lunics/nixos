{
  flake.aspects.zmk.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      zmk-studio    # runtime keymap updates without reflashing firmware
    ];
  };
}
