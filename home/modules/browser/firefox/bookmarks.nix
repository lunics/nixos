{ 
  profiles.PROFILE_NAME.bookmarks = [
    {
      name = "wikipedia";
      tags = [ "wiki" ];
      keyword = "wiki";
      url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
    }
    {
      name = "Nix sites";
      toolbar = true;
      bookmarks = [
        {
          name = "homepage";
          url = "https://nixos.org/";
        }
        {
          name = "wiki";
          tags = [ "wiki" "nix" ];
          url = "https://wiki.nixos.org/";
        }
      ];
    }
  ];
}
