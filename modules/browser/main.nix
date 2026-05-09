{
  flake.aspects.browser.homeManager = { config, ... }:{

    home.sessionVariables.BROWSER = "${config._.browser}";

    _.add_to_startup = [ (if (config._.browser == "zen") then "zen-beta" else config._.browser) ];
  };
}
