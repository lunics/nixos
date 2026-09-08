{
  flake.aspects.zmk.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      zmkbatx       # battery monitoring
      zmk-studio    # runtime keymap updates without reflashing firmware
    ];
  };
}
