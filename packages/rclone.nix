{ pkgs, ... }:{ 
  home.packages = with pkgs; [ rclone ];
  home.file.".config/rclone/rclone.conf".source = ../files/rclone.conf;
}
