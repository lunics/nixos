{
  services.audiobookshelf = {
    enable       = true;
    user         = "audiobookshelf";
    group        = "audiobookshelf";
    port         = 8000;
    dataDir      = "audiobookshelf";
    openFirewall = false;
  };
}

