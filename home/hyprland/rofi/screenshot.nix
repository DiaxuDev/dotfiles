{
  pkgs,
  theme,
  genList,
}:
pkgs.writeShellApplication {
  name = "screenshot";

  text = ''
    # variables
    full="󰊓"
    window="󱂬"
    area="󰏫"

    rofi_cmd() {
      rofi -dmenu \
        -mesg "Screenshot" \
        -theme-str ${genList 3} \
        -theme ${theme}
    }

    run_rofi() {
      echo -e "$area\n$window\n$full" | rofi_cmd
    }

    case $(run_rofi) in
        "$full")
            target='output'
            ;;
        "$window")
            target='active'
            ;;
        "$area")
            target="area"
            ;;
    esac

    grimblast save "$target" - | satty --filename -
  '';
}
