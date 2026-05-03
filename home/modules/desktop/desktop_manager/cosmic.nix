{
  services.desktopManager = {
    cosmic-greeter.enable = true;   # COSMIC login manager

    cosmic = {
      enable = true;
      xwayland.enable = true;
      showExcludedPkgsWarning = true;
    };
  };

  environment.cosmic.excludePackages = with pkgs; [
    # cosmic-edit
  ];

  services.system76-scheduler.enable = true;      # slightly improve the performance

  # bypass default security to enable all windows now have access to the clipboard, globally
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1; 

  # if you want autologin
  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "yourUserName";
  # };
}
