{
  pkgs,
  rofiCmd,
}:
pkgs.writeShellApplication {
  name = "screenshot";

  runtimeInputs = with pkgs; [
    grimblast
  ];

  text = ''
    # variables
    full="󰊓"
    window="󱂬"
    area="󰏫"

    run_rofi() {
      echo -e "$area\n$window\n$full" | ${rofiCmd "Screenshot" 3}
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

    case $1 in
      edit)
        grimblast save "$target" - | satty --filename -
        ;;
      copy)
        grimblast copy "$target"
        ;;
    esac
  '';
}
