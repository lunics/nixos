{
  flake.aspects.zmk.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      zmk-studio    # runtime keymap updates without reflashing firmware
    ];

    _.allow-unfree = with pkgs; [
      simpledbus    # zmkbatx dependencies: SimpleBLE wrappers of libdbus-1 and bluez
      simplebluez
    ];
  };
}
