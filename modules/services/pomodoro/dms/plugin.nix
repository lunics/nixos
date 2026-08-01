{
  flake.aspects.pomodoro.homeManager = { config, lib, pkgs, ... }:{
    config = lib.mkIf (config._.pomodoro && config._.status_bar == "dms"){
      programs.dank-material-shell = {
        plugins.pomodoro.src = pkgs.symlinkJoin {
          name = "dms-pomodoro-plugin";
          paths = [
            (pkgs.writeTextDir "plugin.json" (builtins.toJSON {
              id           = "pomodoro";
              name         = "Pomodoro";
              description  = "Shows the endless-pomodoro state in the bar";
              version      = "1.0.0";
              author       = "lunics";
              type         = "widget";
              capabilities = [ "dankbar-widget" ];
              component    = "./pomodoro.qml";
              icon         = "timer";
            }))

            (pkgs.writeTextDir "pomodoro.qml" (builtins.readFile ./pomodoro.qml))
          ];
        };
      };
    };
  };
}
