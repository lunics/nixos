{ config, ... }:{
  programs.firefox.profiles.${config._.user}.extensions.settings = {
    # get extensions ID: about:debugging#/runtime/this-firefox

    # https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json/permissions
    # TEMPLATE.settings = {
    #   permissions = [
    #     "<all_urls>"      # access your data for all websites ?
    #     "activeTab"       # access your data for all websites ?
    #     "management"      # monitor extension usage and manage themes
    #     "privacy"         # read and modify privacy settings
    #     "tabs"            # access browser tabs
    #     "webNavigation"   # access browser activity during navigation
    #   ];
    # };

    "adnauseam@rednoise.org".settings = {
      permissions = [
        "activeTab"
        "management"
        "privacy"
        "tabs"
        "webNavigation"
      ];
    };
    "leechblockng@proginosko.com".settings = {
      permissions = [
        "activeTab"
        "tabs"
        "webNavigation"
      ];
    };
    "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".settings = {   # refined github
      installation_mode = "force_installed";   # allowed, normal_installed, force_installed, blocked
      default_area      = "navbar";            # menupanel, navbar, tabstrip, personaltoolbar (bookmarks toolbar), titlebar
      permissions = [
        "https://github.com/*"
        "https://api.github.com/*"
        "https://gist.github.com/*"
      ];
    };
    "{762f9885-5a13-4abd-9c77-433dcd38b8fd}".settings = {   # return youtube dislike
      permissions = [
        "https://youtube.com/*"
        "https://returnyoutubedislikeapi.com/*"
      ];
    };
    # "juraj.masiar@gmail.com".settins = {                    # scrollAnywhere    KO
    #   permissions = [
    #     "activeTab"
    #   ];
    # };
  };
}
