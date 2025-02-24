with import <nixpkgs>{};

let
  name = "ankama-launcher";

  ## learn how to install local appimage instead
  src = fetchurl {
    url    = "https://download.ankama.com/launcher/full/linux";
    sha256 = ""; # Change for the sha256 you get after running nix-prefetch-url https://download.ankama.com/launcher/full/linux
    name   = "ankama-launcher.AppImage";
 };

  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/zaap.desktop $out/share/applications/ankama-launcher.desktop
    sed -i 's/.*Exec.*/Exec=ankama-launcher/' $out/share/applications/ankama-launcher.desktop
    install -m 444 -D ${appimageContents}/zaap.png $out/share/icons/hicolor/256x256/apps/zaap.png
  '';
}
