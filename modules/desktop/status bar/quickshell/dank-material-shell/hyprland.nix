{
  flake.aspects.dms.homeManager = { config, lib, ... }: {
    config = lib.mkIf (config._.window_manager == "hyprland") {
      # dms writes these at runtime, so each require is protected: a missing file must not abort the config
      wayland.windowManager.hyprland.extraLuaFiles."dms-includes" = ''
        pcall(function() require("dms.colors") end)
        pcall(function() require("dms.outputs") end)
        pcall(function() require("dms.layout") end)
        pcall(function() require("dms.cursor") end)
        pcall(function() require("dms.windowrules") end)
      '';
    };
  };
}
