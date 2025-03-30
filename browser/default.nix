{ pkgs, inputs, ... }:{

  imports = [
    ./firefox
    # ./librewolf.nix
  ];

  home.packages = with pkgs; [
    # google-chrome
    inputs.zen-browser.packages."${system}".twilight-official
  ];
}
