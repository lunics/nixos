{ pkgs, ... }:{

home.packages = with pkgs; [
  yubikey-touch-detector

  # age-plugin-yubikey
  # age
  # passage
  # pcsclite
];

# https://github.com/maximbaz/yubikey-touch-detector
# services.yubikey-touch-detector.enable = true;
# $ systemctl --user daemon-reload
# $ systemctl --user enable --now yubikey-touch-detector.service
}
