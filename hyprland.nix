{ config, inputs, pkgs, ... }:{

  ## todo https://haseebmajid.dev/posts/2023-11-15-part-3-hyprland-as-part-of-your-development-workflow/

  security.polkit.enable = true;

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true; };

  programs.hyprland = {
    enable          = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = false; };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user    = "lunics"; };
      default_session = initial_session;
    };
  };

  environment.etc."greetd/environments".text = "Hyprland";

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";    # if cursor become invisible
    NIXOS_OZONE_WL = "1";             # Hint electron apps on wayland
  };
}
