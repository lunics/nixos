{
  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = false;   # keep the hardware clock in local time instead of UTC
  };

  i18n = {
    defaultLocale       = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS        = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT    = "fr_FR.UTF-8";
      LC_MONETARY       = "fr_FR.UTF-8";
      LC_NAME           = "fr_FR.UTF-8";
      LC_NUMERIC        = "fr_FR.UTF-8";
      LC_PAPER          = "fr_FR.UTF-8";
      LC_TELEPHONE      = "fr_FR.UTF-8";
      LC_TIME           = "fr_FR.UTF-8";
    }; 
  };

  console  = {
    enable = true;
    keyMap = "fr";
    font   = null;    # lat9w-16 = KO systemd-vconsole-setup.service failed; Unable to find file: lat9w-16
  };
}
