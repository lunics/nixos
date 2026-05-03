{
  programs.mangohud = {             # overlay displaying performance: FPS, Temp, CPU, GPU loads...
    enable            = true;
    enableSessionWide = false;      # Sets environment variables so that MangoHud is started on any application that supports it
    # settings = {
    #   output_folder = ~/Documents/mangohud/;
    #   full = true;
    # };
    # settingsPerApplication = {
    #   mpv = {
    #     no_display = true;
    #   };
    # };
  };
}
