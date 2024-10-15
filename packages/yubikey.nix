{ pkgs, ... }:{

# https://github.com/maximbaz/yubikey-touch-detector

home.packages = with pkgs; [
  yubikey-touch-detector
  age-plugin-yubikey
];

$ systemctl --user daemon-reload
$ systemctl --user enable --now yubikey-touch-detector.service

}
