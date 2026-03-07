{ config, pkgs, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      nu-pomodoro = super.writeScriptBin "nu-pomodoro" ''
        #!${pkgs.nushell}/bin/nu
        
        def pomodoro [
          --work:      int    = 40
          --1st_break: int    = 3
          --unit:      string = "min"  # min, sec
        ] {
          $env.cache_file = "/tmp/pomodoro.json"    # $env instead of let to be accessible in any def
          mkdir ($env.cache_file | path dirname)
          
          let time_unit = if $unit == "sec" { 1sec } else { 1min }
          
          # reduce brightness until 0 when we start a break
          def reduce_brightness [_data: record, _duration: duration = 20sec ] {
            # get current brightness level
            let level = (brightnessctl -m | split row ',' | get 3 | str replace '%' "" | into int)

            # save brightness level in /tmp/pomodoro.json
            mut data = $_data
            $data.brightness = $level
            $data | save -f $env.cache_file
            
            if $level > 0 {   # only run if brightness is above 0
              # calculate delay (total time / number of steps)
              let delay = ($_duration / $level)
              print $"Starting fade out over ($_duration)..."
            
              # loop from 2 up to the current level, 2 instead of 1 to keep 1% of brightness
              1..$level | each { |iter|
                brightnessctl --quiet set 1%-
                # print $"Step: ($iter) of ($level)"
                sleep $delay
              }
            }
          }
          
          # run many system commands to pause everthing before the break
          def break [1st_break: int, time_unit: duration, unit: string, _data: record] {
            mut data = $_data

            $data.break_time = $1st_break * $data.cycle

            $data | save -f $env.cache_file       # finale persistent save

            notify-send -t 10000 -u critical "🍅 Pomodoro" $"Breath and rest your eyes for ($data.break_time)($unit)"
            sleep 10sec
        
            try { playerctl pause }               # to avoid errors of type: No players found
        
            # hyprctl dispatch dpms off
            reduce_brightness $data 20sec

            with-env {
              TASKDATA: ${config._.share}/taskwarrior
              TASKRC:   ${config._.dot_config}/taskwarrior/taskw/taskrc
            } {
              if (which task | is-not-empty) and (task +ACTIVE _ids | str trim | is-not-empty) {
                task +ACTIVE stop
              }
            }

            # swaylock
        
            print $"Break for ($data.break_time * $time_unit) ($unit)"
            sleep ($data.break_time * $time_unit)
        
            # hyprctl dispatch dpms on
            print $"Restore brightness to ($data.brightness)%"
            brightnessctl --quiet set $"($data.brightness)%"
          }

          # if /tmp/pomodoro.json presents then use it else reset the variable
          mut data = if ($env.cache_file | path exists) {
            open $env.cache_file
          } else {
            { cycle: 1, break_time: 0, current_work: 0, last_run: (date now | format date "%Y-%m-%d"), brightness: 0 }
          }

          # reset everything if we start a new day
          if $data.last_run != (date now | format date "%Y-%m-%d") {
            $data = { cycle: 1, break_time: 0, current_work: 0, last_run: (date now | format date "%Y-%m-%d"), brightness: 0 }
          }
          
          if $data.current_work >= 30 {
            $data.cycle = $data.cycle + 1
            $data.current_work = 0
          }

          $data | save -f $env.cache_file         # first persistent save before continue
        
          print $"(ansi green)🍅 Cycle #($data.cycle) - Work for ($work)($unit)(ansi reset)"
          
          for iter in 1..$work {
            sleep (1 * $time_unit)
            $data.current_work = $iter
            $data | save -f $env.cache_file       # persistent save after each minute
          }

          $data.cycle        = $data.cycle + 1
          $data.current_work = 0

          break $1st_break $time_unit $unit $data
        }
        
        pomodoro
      '';
    })
  ];
}
