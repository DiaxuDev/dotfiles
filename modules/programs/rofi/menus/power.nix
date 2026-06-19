{
  pkgs,
  rofiCmd,
}:
pkgs.writeShellApplication {
  name = "powermenu";

  # why are there two uptime versions on linux dawg i spent 10 minutes debugging this shit
  runtimeInputs = [ pkgs.procps ];

  text = ''
    # variables
    uptime="$(uptime -p | sed -e 's/up //g')"
    shutdown='󰐥'
    reboot='󰜉'
    lock='󰌾'
    suspend='󰤄'
    logout='󰍃'
    yes='󰸞'
    no='󱎘'

    confirm_exit() {
      echo -e "$yes\n$no" | ${rofiCmd "Are you sure?" 2}
    }

    run_rofi() {
      echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | ${rofiCmd "Uptime: $uptime" 5}
    }

    # Execute Command
    run_cmd() {
      if [[ "$(confirm_exit)" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
          systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
          systemctl reboot
        elif [[ $1 == '--suspend' ]]; then
          systemctl suspend
        elif [[ $1 == '--logout' ]]; then
          hyprctl dispatch 'hl.dsp.exit()'
        elif [[ $1 == '--lock' ]]; then
          hyprlock
        fi
      else
        exit 0
      fi
    }

    # Actions
    case $(run_rofi) in
    "$shutdown")
      run_cmd --shutdown
      ;;
    "$reboot")
      run_cmd --reboot
      ;;
    "$lock")
      run_cmd --lock
      ;;
    "$suspend")
      run_cmd --suspend
      ;;
    "$logout")
      run_cmd --logout
      ;;
    esac
  '';
}
