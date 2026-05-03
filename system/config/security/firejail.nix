{
programs.firejail = {
  enable = true;
  wrappedBinaries = {
    mpv = {
      executable = "${lib.getBin pkgs.mpv}/bin/mpv";
      profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
    };
    imv = {
      executable = "${lib.getBin pkgs.imv}/bin/imv";
      profile = "${pkgs.firejail}/etc/firejail/imv.profile";
    };
    zathura = {
      executable = "${lib.getBin pkgs.zathura}/bin/zathura";
      profile = "${pkgs.firejail}/etc/firejail/zathura.profile";
    };
    discord = {
      executable = "${lib.getBin pkgs.discord}/bin/discord";
      profile = "${pkgs.firejail}/etc/firejail/discord.profile";
    };
    slack = {
      executable = "${lib.getBin pkgs.slack}/bin/slack";
      profile = "${pkgs.firejail}/etc/firejail/slack.profile";
    };
    telegram-desktop = {
      executable = "${lib.getBin pkgs.tdesktop}/bin/telegram-desktop";
      profile = "${pkgs.firejail}/etc/firejail/telegram-desktop.profile";
    };
    brave = {
      executable = "${lib.getBin pkgs.brave}/bin/brave";
      profile = "${pkgs.firejail}/etc/firejail/brave.profile";
    };
    qutebrowser = {
      executable = "${lib.getBin pkgs.qutebrowser}/bin/qutebrowser";
      profile = "${pkgs.firejail}/etc/firejail/qutebrowser.profile";
    };
    thunar = {
      executable = "${lib.getBin pkgs.xfce.thunar}/bin/thunar";
      profile = "${pkgs.firejail}/etc/firejail/thunar.profile";
    };
    vscodium = {
      executable = "${lib.getBin pkgs.vscodium}/bin/vscodium";
      profile = "${pkgs.firejail}/etc/firejail/vscodium.profile";
    };
  };

}; }
