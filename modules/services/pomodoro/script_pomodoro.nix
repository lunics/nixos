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
          $env.cache_file = "/tmp/pomodoro.json"    # $env instead of let to be accessible in any def
          mkdir ($env.cache_file | path dirname)
          
          let time_unit = if $unit == "sec" { 1sec } else { 1min }
          
          mut data = if ($env.cache_file | path exists) {
            open $env.cache_file
          } else {
            { cycle: 1, break: 0, current_work: 0, last_run: (date now | format date "%Y-%m-%d"), brightness: 0 }
          }

          if $data.last_run != (date now | format date "%Y-%m-%d") {
            $data = { cycle: 1, break: 0, current_work: 0, last_run: (date now | format date "%Y-%m-%d"), brightness: 0 }
          }

          def reduce_brightness [_data: record, _duration: duration = 20sec ] {
            # get current brightness level
            let level = (brightnessctl -m | split row ',' | get 3 | str replace '%' "" | into int)

            # save level in /tmp/pomodoro.json
            mut data = $_data
            $data.brightness = $level
            $data | save -f $env.cache_file
            
            if $level > 0 {   # only run if brightness is above 0
              # calculate delay (total time / number of steps)
              let delay = ($_duration / $level)
              print $"Starting fade out over ($_duration)..."
            
              # loop from 2 up to the current level, 2 instead of 1 to keep 1% of brightness
              2..$level | each { |iter|
                brightnessctl --quiet set 1%-
                # print $"Step: ($iter) of ($level)"
                sleep $delay
              }
            }
          }
          
          def take_break [break_time: int, time_unit: duration, unit: string, _data: record] {
            notify-send -t 10000 -u critical "🍅 Pomodoro" $"Breath and rest your eyes for ($break_time)($unit)"
            sleep 10sec
        
            playerctl pause
        
            # hyprctl dispatch dpms off
            reduce_brightness $_data 20sec

            with-env {
              TASKDATA: ${config._.share}/taskwarrior
              TASKRC:   ${config._.dot_config}/taskwarrior/taskw/taskrc
            } {
              if (which task | is-not-empty) and (task +ACTIVE _ids | str trim | is-not-empty) {
                task +ACTIVE stop
              }
            }
        
            print $"(char bel)(ansi yellow)✓ Break ($break_time)($unit)(ansi reset)"
            sleep ($break_time * $time_unit)
        
            # hyprctl dispatch dpms on
            brightnessctl --quiet set $"($_data.brightness)%"
        
            return $break_time
          }
          
          if $data.current_work >= 3 {
            $data.cycle = $data.cycle + 1
            $data.current_work = 0
          }

          $data | save -f $env.cache_file
          
          loop {
            let break_time = $1st_break * $data.cycle
        
            print $"(ansi green)🍅 Cycle #($data.cycle) - Work ($work)($unit)(ansi reset)"
            
            for _ in 1..$work {
              sleep (1 * $time_unit)
              $data.current_work = $data.current_work + 1
              $data | save -f $env.cache_file
            }
            
            $data.break = (take_break $break_time $time_unit $unit $data)
        
            $data.current_work = 0
            $data.last_run = (date now | format date "%Y-%m-%d")
            $data | save -f $env.cache_file
            
            $data.cycle = $data.cycle + 1
          }
        }
        
        pomodoro
      '';
    })
  ];
}
