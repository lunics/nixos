{ pkgs, ... }:{

  security.polkit = {
    enable  = true;
    package = pkgs.polkit;
    adminIdentities = [
      "unix-group:wheel"
    ];

    extraConfig = ''
      // v2 enable udiskie/udisks to mount usb drive in user space
      polkit.addRule(function(action, subject) {
          if (subject.isInGroup("wheel")) {
              if (action.id.startsWith("org.freedesktop.udisks2.")) {
                  return polkit.Result.YES;
              }
          }
      });

      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }
      });
    '';
  };
}
      # // v1 enable udiskie/udisks to mount usb drive in user space
      # polkit.addRule(function(action, subject) {
      #   var YES = polkit.Result.YES;
      #   var permission = {
      #     // required for udisks2:
      #     "org.freedesktop.udisks2.filesystem-mount": YES,
      #     "org.freedesktop.udisks2.encrypted-unlock": YES,
      #     "org.freedesktop.udisks2.eject-media": YES,
      #     "org.freedesktop.udisks2.power-off-drive": YES,

      #     // Dolphin specific
      #     "org.freedesktop.udisks2.filesystem-mount-system": YES,

      #     // required for udisks2 if using udiskie from another seat (e.g. systemd):
      #     "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
      #     "org.freedesktop.udisks2.filesystem-unmount-others": YES,
      #     "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
      #     "org.freedesktop.udisks2.eject-media-other-seat": YES,
      #     "org.freedesktop.udisks2.power-off-drive-other-seat": YES
      #   };
      #   if (subject.isInGroup("storage")) {
      #     return permission[action.id];
      #   }
      # });
