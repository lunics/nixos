{ pkgs, inputs, ... }:{

  imports = [
    ./firefox
    ./librewolf.nix
    ./chromium.nix
    ./psd.nix
  ];

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".twilight-official
  ];
}
