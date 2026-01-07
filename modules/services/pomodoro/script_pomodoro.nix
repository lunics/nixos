{ config, pkgs, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      nu-pomodoro = super.writeScriptBin "nu-pomodoro" ''
        #!${pkgs.nushell}/bin/nu
        
        def pomodoro [
          --work:      int = 40
          --1st_break: int = 3
          --unit:      string = "min"  # min, sec
        ] {
          let cache_file = "/tmp/pomodoro.json"
          mkdir ($cache_file | path dirname)
          
          let time_unit = if $unit == "sec" { 1sec } else { 1min }
          
          mut data = if ($cache_file | path exists) {
            open $cache_file
          } else {
            { cycle: 1, break: 0, current_work: 0, last_run: (date now | format date "%Y-%m-%d") }
          }
          
          def take_break [break_time: int, time_unit: duration, unit: string] {
            notify-send -t 10000 -u critical "🍅 Pomodoro" $"Breath and rest your eyes for ($break_time)($unit)"
            sleep 10sec
        
            playerctl pause
        
            hyprctl dispatch dpms off

            with-env {
              TASKDATA: ${config._.share}/taskwarrior
              TASKRC:   ${config._.dot_config}/taskwarrior/taskw/taskrc
            } {
              if (which task | is-not-empty) and (task +ACTIVE _ids | is-not-empty) {
                task +ACTIVE stop
              }
            }
        
            print $"(char bel)(ansi yellow)✓ Break ($break_time)($unit)(ansi reset)"
            sleep ($break_time * $time_unit)
        
            hyprctl dispatch dpms on
        
            return $break_time
          }
          
          if $data.current_work >= 3 {
            $data.cycle = $data.cycle + 1
            $data.current_work = 0
          }

          $data | save -f $cache_file
          
          loop {
            let break_time = $1st_break * $data.cycle
        
            print $"(ansi green)🍅 Cycle #($data.cycle) - Work ($work)($unit)(ansi reset)"
            
            for _ in 1..$work {
              sleep (1 * $time_unit)
              $data.current_work = $data.current_work + 1
              $data | save -f $cache_file
            }
            
            $data.break = (take_break $break_time $time_unit $unit)
        
            $data.current_work = 0
            $data.last_run = (date now | format date "%Y-%m-%d")
            $data | save -f $cache_file
            
            $data.cycle = $data.cycle + 1
          }
        }
        
        pomodoro
      '';
    })
  ];
}
