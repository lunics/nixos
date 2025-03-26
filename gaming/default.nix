{
  imports = [
    ./steam.nix
  ];
  # environment.systemPackages = with pkgs; [ mangohud ];   # overlay displaying FPS, Temp, CPU, GPU loads...
  programs.gamemode.enable = true;    # daemon that greatly improve game's performance, applying temporary optimizations to the OS and game process
    # Add steam general options cmd:
    #   gamemoderun %command%
    #   mangohud %command%
    #   gamescope %command%
}
