{ config, pkgs, ... }:
let
  scriptOverlay = self: super: {
    update-wallpaper = super.writeShellApplication {
      name = "update-wallpaper";

      excludeShellChecks = [ "SC2086" "SC2046" "SC1091" "SC2012" ];

      runtimeInputs = with super; [
        awww 
        coreutils   # for shuf to get a random value
      ];

      text = ''
        # source /home/''\${UID}/.nix-profile/etc/profile.d/hm-session-vars.sh
        
        path_wallpapers="/home/$USER/usb_copy/homelab/share/wallpapers"
        
        max_wallpapers=$(ls -1 $path_wallpapers | wc -l)
        
        # awww query 
        #   ${config._.share}/wallpapers/summer-anime-girl-cat-4k-wallpaper-uhdpaper.com-414@5@d.jpg
        
        selected_line=$(shuf -i 0-''\${max_wallpapers} -n 1)
        
        selected_wallpaper=$(ls -1 $path_wallpapers | sed -n "''\${selected_line}p")
        
        echo "Wallpaper name: $selected_wallpaper"
        
        awww img "$path_wallpapers/$selected_wallpaper" --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 3 --invert-y
      '';
    };
  };
in {
  nixpkgs.overlays = [ scriptOverlay ];

  home.packages = [ pkgs.update-wallpaper ];
}
