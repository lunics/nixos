{ pkgs, inputs, ... }:{

  imports = [
    ./firefox
    ./librewolf.nix
  ];

  # replaced by manual sync profile
  # services.psd = {
  #   enable = true;
  #   resyncTimer = "1h";
  # };

  home.packages = with pkgs; [
    # google-chrome
    inputs.zen-browser.packages."${system}".twilight-official
  ];
}
