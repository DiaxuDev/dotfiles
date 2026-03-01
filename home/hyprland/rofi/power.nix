{
  pkgs,
  theme,
  genList,
}:
pkgs.writeShellApplication {
  name = "powermenu";

  text = ''
    # variables
    uptime="$(${pkgs.procps}/bin/uptime -p | sed -e 's/up //g')" # why are there two uptime versions on linux dawg i spent 10 minutes debugging this shit
    shutdown='󰐥'
    reboot='󰜉'
    lock='󰌾'
    suspend='󰤄'
    logout='󰍃'
    yes='󰸞'
    no='󱎘'

    rofi_cmd() {
      rofi -dmenu \
        -mesg "Uptime: $uptime" \
        -theme-str ${genList 5} \
        -theme ${theme}
    }

    confirm_cmd() {
      rofi -dmenu \
        -theme-str ${genList 2} \
        -mesg 'Are you sure?' \
        -theme ${theme}
    }

    confirm_exit() {
      echo -e "$yes\n$no" | confirm_cmd
    }

    run_rofi() {
      echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
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
          hyprctl dispatch exit
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
