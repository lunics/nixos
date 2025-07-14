{ config, options, ... }:{
  imports = [
    ../modules/hardware.nix
    ../modules/disk
    ../modules/boot.nix
    ../modules/nix
    ../modules/configuration.nix
    ../modules/kernel.nix
    # ./swap.nix
    # ./etc
    # ./services
    ../modules/location.nix
    ../modules/network
    ../modules/ntp.nix
    ../modules/users.nix
    ../modules/login_manager.nix
    ../modules/security
    ../modules/fonts.nix
    # ./server
  ];

  # options.my = {
  #   pomodoro = lib.mkOption {
  #     type    = lib.types.bool;
  #     default = false;
  #   };
  # };
}
