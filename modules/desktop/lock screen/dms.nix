{
  flake.aspects.dms-lock.homeManager = { ... }:{
    _.lock-screen = "dms";
    _.lock-cmd    = "dms ipc call lock lock";

    programs.dank-material-shell.settings = {
      lockScreenShowTime          = true;
      lockScreenClockStyle        = "horizontal";  # horizontal, vertical
      lockScreenShowDate          = true;
      lockDateFormat              = "";            # empty = locale format
      lockScreenFontFamily        = "";            # empty = shell font

      lockScreenShowProfileImage  = true;
      lockScreenShowPasswordField = true;
      lockScreenShowPowerActions  = true;
      lockScreenShowSystemIcons   = true;
      lockScreenShowMediaPlayer   = true;
      lockScreenShowWeather       = true;

      # 0 = hidden, 1 = count only, 2 = full content
      lockScreenNotificationMode  = 0;

      loginctlLockIntegration          = true;       # dms answers the logind Lock signal itself
      customPowerActionLock            = "";         # dms shows its own lock surface

      lockAtStartup                    = false;
      lockBeforeSuspend                = true;
      lockScreenPowerOffMonitorsOnLock = false;
      lockScreenInactiveColor          = "#000000";  # colour of the screens without the unlock form
    };
  };
}
