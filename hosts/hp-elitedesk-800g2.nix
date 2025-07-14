{ config, options, ... }:{
  imports = [
    ../hardware.nix
    ../disk
    ../boot.nix
    ../nix
    ../configuration.nix
    ../kernel.nix
    # ./swap.nix
    # ./etc
    # ./services
    ../location.nix
    ../network
    ../ntp.nix
    ../users.nix
    ../login_manager.nix
    ../security
    ../fonts.nix
    # ../server
  ];

  # options.my = {
  #   pomodoro = lib.mkOption {
  #     type    = lib.types.bool;
  #     default = false;
  #   };
  # };
}
