{ config, ... }:{
  programs.anki = {
    enable             = true;
    # package          = pkgs.anki;
    style              = null;            # null, anki, native
    theme              = "followSystem";  # null, followSystem, light, dark
    videoDriver        = null;            # null, opengl, angle, software, metal, vulkan, d3d11
    uiScale            = null;            # between 0.0 and 1.0
    hideTopBar         = false;           # hide top bar during review
    hideTopBarMode     = null;            # null, fullscreen, always
    hideBottomBar      = false;           # ide bottom bar during review
    hideBottomBarMode  = null;            # null, fullscreen, always
    spacebarRatesCard  = null;
    reduceMotion       = null;
    minimalistMode     = null;
    language           = "fr_FR";         # display language
    legacyImportExport = null;            # use legacy (pre 2.1.55) import/export handling code
    answerKeys = [
      {
        ease = 1;                         # 1 = Again, 2 = Hard, 3 = Good, and 4 = Easy
        key  = "left";                    # keyboard shortcut: https://doc.qt.io/qt-6/qkeysequence.html
      }
      {
        ease = 2;
        key  = "up";
      }
      {
        ease = 3;
        key  = "right";
      }
      {
        ease = 4;
        key  = "down";
      }
    ];
    profiles.$config._.user = {
      sync = {
        username             = null;
        url                  = null;
        syncMedia            = null;
        keyFile              = null;
        usernameFile         = null;
        networkTimeout       = null;
        autoSync             = null;
        autoSyncMediaMinutes = null;        # 0 = disable periodic media syncing. sync media every X minutes
      };
    };
    addons = [];
  };
}
